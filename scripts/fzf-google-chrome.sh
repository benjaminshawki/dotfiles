#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rbconfig'
require 'tempfile'
require 'json'
require 'open3'
require 'shellwords'
require 'sqlite3'
require 'ansi256'

# Chrome fzf integration
module ChromeFzf
  extend self

  # Platform-specific constants.
  BASE_PATH, OPEN_COMMAND, CLIP_COMMAND =
    case RbConfig::CONFIG['host_os']
    when /darwin/
      ['Library/Application Support/Google/Chrome', 'open {+2}', 'echo -n {+2} | pbcopy']
    when /linux/
      ['.config/google-chrome', 'google-chrome-stable {+2}', 'echo -n {+2} | wl-copy']
    else
      ['AppData\Local\Google\Chrome\User Data', 'start {+2}', 'echo {+2} | clip']
    end

  def run(type)
    Open3.popen2(fzf(type)) do |stdin, _stdout|
      list(type, stdin)
    end
  rescue Errno::EPIPE
    # Ignore broken pipe error
  end

  def list(type, io = $stdout)
    method(type).call.each do |title, url, time|
      format(io, title, url, time)
    end
  end

  private

  def path(name) = File.join(Dir.home, BASE_PATH, 'Default', name)

  # Build fzf command
  def fzf(name)
    <<~CMD
      fzf --ansi --read0 --multi --info inline-right --reverse --scheme history \\
          --highlight-line --cycle --tmux 100% --wrap --wrap-sign ' ↳ ' \\
          --border --border-label " Chrome::#{name.capitalize} " --delimiter "\n · " \\
          --header '╱ CTRL-B: Bookmarks ╱ CTRL-H: History ╱ CTRL-Y: Copy to clipboard ╱\n\n' \\
          --bind 'enter:execute-silent(#{OPEN_COMMAND})+deselect-all' \\
          --bind 'ctrl-y:execute-silent(#{CLIP_COMMAND})+deselect-all' \\
          --bind 'ctrl-b:reload(ruby #{__FILE__.shellescape} --list b)+change-border-label( Chrome::Bookmarks )+top' \\
          --bind 'ctrl-h:reload(ruby #{__FILE__.shellescape} --list h)+change-border-label( Chrome::History )+top'
    CMD
  end

  def format(io, title, url, time)
    time = Time.at(time.to_i / 1_000_000 - 11_644_473_600).strftime('%F %T')
    io.puts "#{title} (#{time})".strip
    io.print " · #{url}\n\x0"
  end

  def history
    Tempfile.create('chrome') do |temp|
      temp.close
      FileUtils.cp(path('History'), temp.path)
      SQLite3::Database.open(temp.path) do |db|
        db.execute('select title, url, last_visit_time from urls order by last_visit_time desc')
      end
    end
  end

  def bookmarks
    build = lambda do |parent, json|
      name = [parent, json[:name]].compact.join('/')
      if json[:type] == 'folder'
        json[:children].flat_map { |child| build[name, child] }
      else
        [[name, json[:url], json.values_at(:date_last_used, :date_added).max]]
      end
    end

    JSON.load_file(path('Bookmarks'), symbolize_names: true)
        .fetch(:roots, {})
        .values
        .flat_map { |e| build[nil, e] }
        .sort_by(&:last)
        .reverse
  end
end

method = ARGV.delete('--list') ? :list : :run
type = case ARGV[0]&.downcase
       when 'b' then :bookmarks
       when 'h', nil then :history
       else abort "Usage: #{__FILE__} [--list] [b|h]"
       end

ChromeFzf.send(method, type)

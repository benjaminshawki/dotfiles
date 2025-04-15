-- Dart/Flutter language support
return {
  "dart-lang/dart-vim-plugin",
  ft = { "dart" },
  init = function()
    vim.g.dart_style_guide = 2
    vim.g.dart_format_on_save = 1
  end
}
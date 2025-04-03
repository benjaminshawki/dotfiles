return {
	"neo451/feed.nvim",
	cmd = "Feed",
	---@module 'feed'
	---@type feed.config
	opts = {
		feeds = {
			"https://neovim.io/news.xml",
			"https://this-week-in-neovim.org/rss",
			"https://devblogs.microsoft.com/typescript/feed/",
			"https://javascriptweekly.com/rss",
			"https://blog.rust-lang.org/feed.xml",
			"https://swaywm.org/feed.xml",
			"https://lwn.net/headlines/rss",
			"https://blog.github.com/feed.xml",
			"https://www.anthropic.com/news/rss",
			"https://web.dev/feed.xml",
		},
	},
}

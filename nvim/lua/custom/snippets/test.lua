local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("javascript", {
	s("test", { t('console.log("Hello World!");') }),
})

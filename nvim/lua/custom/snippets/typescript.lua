local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

local filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

for _, ft in ipairs(filetypes) do
	ls.add_snippets(ft, {
		s("impmsg", { t('import * as m from "@/paraglide/messages.js";') }),
	})
end

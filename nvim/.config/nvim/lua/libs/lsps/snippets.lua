-- luasnip setup
-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L190
local luasnip = require("luasnip")
local s = luasnip.snippet
--local sn = luasnip.snippet_node
--local t = luasnip.text_node
--local i = luasnip.insert_node
local f = luasnip.function_node
--local c = luasnip.choice_node
--local d = luasnip.dynamic_node
--local r = luasnip.restore_node

luasnip.add_snippets("markdown", {
	s("journal template", {
		f(function()
			return { os.date("# %Y-%m-%d"), "", "## Meetings", "", "### Standup", "", "## Tasks" }
		end),
	}),
})

require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		--["<Tab>"] = cmp.mapping(function(fallback)
		--if cmp.visible() then
		--cmp.select_next_item()
		--elseif luasnip.expand_or_jumpable() then
		--luasnip.expand_or_jump()
		--else
		--fallback()
		--end
		--end, { "i", "s" }),
		--["<S-Tab>"] = cmp.mapping(function(fallback)
		--if cmp.visible() then
		--cmp.select_prev_item()
		--elseif luasnip.jumpable(-1) then
		--luasnip.jump(-1)
		--else
		--fallback()
		--end
		--end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
	},
})

local cmp = require 'cmp'
cmp.register_source('path', require('lsp.path').new())
cmp.setup({
	mapping = {
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		})
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	sources = {
		{ name = 'path' },
		{ name = 'look' },
		{ name = 'nvim_lsp' },
	},
	--menu width
	formatting = {
		fields = { "abbr", "menu", "kind" };
		format = function(entry, vim_item)
			local kind_icons = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "ﰠ",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "塞",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			vim_item.abbr = string.sub(vim_item.abbr, 1, 66)
			return vim_item
		end
	},
	experimental = {
		ghost_text = true,
		native_menu = false
	}
})
require 'cmp'.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})
--Completion colors
--vim.cmd('highlight! link cmpDocumentation red')
--vim.cmd('highlight Pmenu guibg=#011527 guifg=#3c4142')
vim.cmd('highlight Pmenu guibg=#NONE guifg=#011527')
vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#ffffff')
vim.cmd('highlight! CmpItemKindClass guibg=NONE guifg=#64b500')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindSnippet guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight! CmpItemKindFolder guibg=NONE guifg=#64b500')
vim.cmd('highlight! CmpItemKindFile guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindField guibg=NONE guifg=#C586C0')

--<C-j>, <C-k> mapping
_G.Next = function(str)
	str = "<C-n>"
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.previous = function(str)
	str = "<C-p>"
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.Next()", { expr = true })
vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.previous()", { expr = true })

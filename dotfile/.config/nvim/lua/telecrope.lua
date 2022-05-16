require('telescope').setup {
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		initial_mode = "insert",
		path_display = { "truncate" },
	},
	file_sorter = require("telescope.sorters").get_fuzzy_file,
	generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	}
}
require('telescope').load_extension('fzf')

--Allow insert the search_dirs first
_G.open_telescope = function()
	Dir = vim.fn.input("Dir is: ", "~/")
	require("telescope.builtin").find_files({ search_dirs = { Dir }, hidden = true })
end

vim.api.nvim_set_keymap('n', '<leader>ff', ':lua open_telescope()<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<CR>', { noremap = true, silent = false }) -- need ripgrep!!!

--compile...
_G.compile = function()
	if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
		Option = vim.fn.input("do u want use less? (y/n):")
		if Option == "n" then
			vim.cmd([[exec 'silent !g++ -o a.out %']])
			--vim.cmd([[exec "silent !alacritty -e bash -c './a.out'"]])
			vim.cmd([[exec "silent terminal ./a.out"]])
			vim.cmd([[exec 'silent !rm a.out']])
		elseif Option == "y" then
			vim.cmd([[exec 'silent !g++ -o a.out %']])
			--vim.cmd([[exec "silent !alacritty -e bash -c './a.out | less' && bash"]])
			vim.cmd([[exec "silent terminal ./a.out | less"]])
			vim.cmd([[exec 'silent !rm a.out']])
		end
	elseif vim.bo.filetype == "java" then
		Option = vim.fn.input("do u want use less? (y/n):")
		if Option == "n" then
			vim.cmd([[exec 'silent !javac %']])
			--vim.cmd([[exec "silent !alacritty -e bash -c 'java % && exit'"]])
			vim.cmd([[exec "silent terminal java %"]])
		elseif Option == "y" then
			vim.cmd([[exec 'silent !javac %']])
			--vim.cmd([[exec "silent !alacritty -e bash -c 'java % | less && exit'"]])
			vim.cmd([[exec "silent terminal java % | less"]])
		end
	end
end
vim.api.nvim_set_keymap('n', '<leader>cc', ':lua compile()<cr>', { noremap = true, silent = true })

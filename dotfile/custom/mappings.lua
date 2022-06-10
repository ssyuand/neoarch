-- n, v, i are mode names

local function termcodes(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

local M = {}
--Mapping
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv=gv") -- Moving block up
vim.keymap.set('v', '<S-up>', ":m '<-2<CR>gv=gv") -- Moving block down

M.general = {

   n = {
      [";"] = {":", opts = {}},
      ["<S-Down>"] = {"<cmd> m .+1 <CR>==", opts = {}},
      ["<S-up>"] = {"<cmd> m .-2 <CR>==", opts = {}},
      ["<C-l>"] = { "<cmd> noh <CR>", opts = {}},
      ["<C-q>"] = { "<cmd> quit <CR>", opts = {}},
      ["<leader>c"] = {
       function ()
	if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
		Option = vim.fn.input("do u want use less? (y/n):")
		if Option == "n" then vim.cmd([[exec 'silent !g++ -o a.out %']])
			vim.cmd([[exec "silent terminal ./a.out"]])
			vim.cmd([[exec 'silent !rm a.out']])
		elseif Option == "y" then
			vim.cmd([[exec 'silent !g++ -o a.out %']] and [[exec "silent terminal ./a.out | less"]])
			vim.cmd([[exec 'silent !rm a.out']])
		end
	elseif vim.bo.filetype == "java" then
		Option = vim.fn.input("do u want use less? (y/n):")
		if Option == "n" then
			vim.cmd([[exec 'silent !javac %']] and [[exec "silent terminal java %"]])
		elseif Option == "y" then
			vim.cmd([[exec 'silent !javac %']] and [[exec "silent terminal java % | less"]])
		end
            end
	end
     },
   },
}
M.lspconfig = {
   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
   n = {
      ["<leader>q"] = {
         function()
            vim.diagnostic.setloclist()
         end,
      },
      ["<leader>f"] = {
         function()
           vim.lsp.buf.formatting()
         end,
      },

   },
}

return M

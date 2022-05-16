local g = vim.g
local o = vim.opt
local bo = vim.bo
local wo = vim.wo
o.fileencodings = "ucs-bom,utf-8,gbk,big5,latin1"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
wo.number = true --Show number
wo.relativenumber = true --Relative number
o.pumheight = 10 -- limit autocomple candidates
o.undofile = true --undofile
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.title = true --Show title in GUI
o.cmdheight = 1 -- better display for messages
o.termguicolors = true --Ture color
o.errorbells = true --Close warning bell
o.ignorecase = true --Regardless Upperlowercase
o.showmode = false --No show mode
bo.swapfile = false --No swap file
o.backup = false --No backup
wo.wrap = false --No wrap
o.incsearch = true --Show search
o.hidden = true --Save buffer
o.tabstop = 4 --Tab stop
o.shiftwidth = 4 --Shift width
wo.signcolumn = 'yes' --show signcolumn
o.cursorline = true
--o.fdm = indent 			 		--set fold method to indent

--webicon
require 'nvim-web-devicons'.setup { default = true; }

--Mapping
g.mapleader = ';'

local key_map = function(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end
key_map('n', ';', ':') --Let (; = :)
key_map('v', '<C-c>', '"+yy') --need install xclip

--no auto-comment
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
--hide "~"
vim.cmd([[set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾]]);
--vim.cmd([[hi EndOfBuffer guifg=#011627]])
--signColumn color
vim.cmd([[:highlight SignColumn guibg=NONE guifg=#011627]])
--signColumn number
vim.cmd([[:highlight LineNr guifg=#011627 ]])
vim.cmd([[:highlight CursorLineNr guifg=#FFc0CB ]])
--Mark
vim.cmd([[hi Visual guibg=NONE guifg=#ffff33]])
--CursorLine
vim.cmd([[hi CursorLine  guibg=NONE guifg=NONE]]);

local M = {}

M.base_30 = {
   white = "#dee1e6",
   darker_black = "#1a1a1a",
   black = "#FFFFFF", --  nvim bg
   black2 = "#252525",
   one_bg = "#282828",
   one_bg2 = "#313131",
   one_bg3 = "#3a3a3a",
   grey = "#444444",
   grey_fg = "#4e4e4e",
   grey_fg2 = "#585858",
   light_grey = "#626262",
   red = "#D16969",
   baby_pink = "#ea696f",
   pink = "#bb7cb6",
   line = "#2e2e2e", -- for lines like vertsplit
   green = "#B5CEA8",
   vibrant_green = "#bfd8b2",
   blue = "#569CD6",
   nord_blue = "#60a6e0",
   yellow = "#D7BA7D",
   sun = "#e1c487",
   purple = "#c68aee",
   dark_purple = "#b77bdf",
   teal = "#4EC994",
   orange = "#CE9178",
   cyan = "#9CDCFE",
   statusline_bg = "#242424",
   lightbg = "#303030",
   pmenu_bg = "#264f78", --select...
   folder_bg = "#7A8A92",
   vscNone = 'NONE',
   vscFront = '#D4D4D4',
   vscBack = '#1e1e1e',
   -- Syntax colors
   vscGray = '#808080',
   vscViolet = '#646695',
   vscBlue = '#569CD6',
   vscDarkBlue = '#223E55',
   vscMediumBlue = '#18a2fe',
   vscLightBlue = '#9CDCFE',
   vscGreen = '#6A9955',
   vscBlueGreen = '#4EC9B0',
   vscLightGreen = '#B5CEA8',
   vscRed = '#F44747',
   vscOrange = '#CE9178',
   vscLightRed = '#D16969',
   vscYellowOrange = '#D7BA7D',
   vscYellow = '#DCDCAA',
   vscPink = '#C586C0',
   vscPopupFront = '#000000',
}

M.base_16 = {
   --author of this template Tomas Iser, @tomasiser on github,
   base00 = "#1E1E1E",
   base01 = "#262626",
   base02 = "#303030",
   base03 = "#3C3C3C",
   base04 = "#464646",
   base05 = "#D4D4D4",
   base06 = "#E9E9E9",
   base07 = "#FFFFFF",
   base08 = "#C586C0", --conditional expressions
   base09 = "#B5CEA8",
   base0A = "#569CD6", --fuc name
   base0B = "#BD8D78",
   base0C = "#9CDCFE",
   base0D = "#DCDCAA",
   base0E = "#C586C0",
   base0F = "#CE9178",
}

M.polish_hl = {
   NormalFloat = {
      bg = M.base_30.vscNone
   },
   Normal = {
       bg = M.base_30.vscBack
   },
   Pmenu = {
       bg = M.base_30.vscNone
   },
   TSError = { --return
      fg = M.base_30.red
   },
   TSKeywordReturn = { --return
      fg = M.base_30.vscLightBlue
   },
   TSString = { --String ex "123"
      fg = M.base_30.vscOrange
   },
   TSPunctBracket = { -- {} ()...
      fg = M.base_30.vscFront
   },
   TSConstant = { -- final in java... const in c....
      fg = M.base_30.vscYellow
   },
   TSConstBuiltin = { -- null..
      fg = M.base_30.vscBlue
   },
   TSNumber = { -- number
      fg = M.base_30.vscLightGreen
   },
   TSCharacter = { -- char ex. 'c'
      fg = M.base_30.vscOrange
   },
   TSConstMacro = { --#include in c
      fg = M.base_30.vscBlueGreen
   },
   TSFloat = { --true/false
      fg = M.base_30.vscLightGreen
   },
   TSAnnotation = { --true/false
      fg = M.base_30.vscYellow
   },
   TSAttribute = { --true/false
      fg = M.base_30.vscBlueGreen
   },
   TSNamespace = { --true/false
      fg = M.base_30.vscBlueGreen
   },
   TSFuncBuiltin = { --true/false
      fg = M.base_30.vscYellow
   },
   TSFunction = {
      fg = M.base_30.vscYellow
   },
   TSFuncMacro = {
      fg = M.base_30.vscYellow
   },
   TSParameter = {
      fg = M.base_30.vscLightBlue
   },
   TSParameterReference = {
      fg = M.base_30.vscLightBlue
   },
   TSMethod = { --fun and method name
      fg = M.base_30.vscYellow
   },
   TSField = { --fun and method name
      fg = M.base_30.vscLightBlue
   },
   TSProperty = {
      fg = M.base_30.vscLightBlue
   },
   TSConstructor = {
      fg = M.base_30.vscBlueGreen
   },
   TSConditional= {
      fg = M.base_30.vscPink
   },
   TSRepeat = {
      fg = M.base_30.vscPink
   },
   TSLabel = {
      fg = M.base_30.vscLightBlue
   },
   TSKeyword = { --class static...
      fg = M.base_30.vscBlue
   },
   TSKeywordFunction = {
      fg = M.base_30.vscBlue
   },
   TSKeywordOperator = {
      fg = M.base_30.vscBlue
   },
   TSOperator = {
      fg = M.base_30.vscFront
   },
   TSException = {
      fg = M.base_30.vscPink
   },
   TSType = {
      fg = M.base_30.vscBlue
   },
   TSTypeBuiltin = {
      fg = M.base_30.vscBlue
   },
   TSStructure = {
      fg = M.base_30.vscLightBlue
   },
   TSInclude = {
      fg = M.base_30.vscPink
   },
   TSVariable = {
      fg = M.base_30.vscLightBlue
   },
   TSText = {
      fg = M.base_30.vscFront
   },
   TSUnderline = {
      fg = M.base_30.vscYellowOrange
   },
   TSTag = {
      fg = M.base_30.vscBlue
   },
   TSTagDelimiter = {
      fg = M.base_30.vscGray
   },
   TSTitle = {
      fg = M.base_30.vscBlue
   },
   TSLiteral = {
      fg = M.base_30.vscFront
   },
   TSEmphasis = {
      fg = M.base_30.vscFront
   },
   TSStrong = {
      fg = M.base_30.vscBlue
   },
   TSURI = {
      fg = M.base_30.vscFront
   },
   TSTextReference = {
      fg = M.base_30.vscOrange
   },
   TSPunctDelimiter = {
      fg = M.base_30.vscFront
   },
   TSStringEscape = {
      fg = M.base_30.vscOrange
   },
   TSNote = {
      fg = M.base_30.vscBlueGreen
   },
   TSWarning = {
      fg = M.base_30.vscYellowOrange
   },
   TSDanger= {
      fg = M.base_30.vscRed
   },
   TSComment = {
      fg = M.base_30.vscGreen
   },
   --LSP
   DiagnosticWarn = {
      fg = M.base_30.vscYellow
   },
   DiagnosticError = {
      fg = M.base_30.vscRed
   },
   DiagnosticInfo = {
      fg = M.base_30.vscBlue
   },
   --Lua
   luaFuncArgName = {
      fg = M.base_30.vscBlue
   },

}

M.type = "dark"

M = require("base46").override_theme(M, "vscode_dark")

return M

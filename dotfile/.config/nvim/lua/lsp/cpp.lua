--[[
require'lspconfig'.ccls.setup {
    cmd = { "ccls" },
	init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clangd = {
	    excludeArgs = { "-frounding-math"},
     }
  }

}
--]]
require'lspconfig'.clangd.setup{}

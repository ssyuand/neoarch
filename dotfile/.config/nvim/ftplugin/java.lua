--require'lspconfig'.jdtls.setup{ cmd = { 'jdtls' } }
USER = vim.fn.expand('$USER')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')


local config = {
  cmd = {
    '/usr/lib/jvm/java-18-openjdk/bin/java', -- or '/path/to/java11_or_newer/bin/java'
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
	-- must use /home/urname/... don't use ~/urname/library or $HOME/library... !!!!!!
    '-jar', '/home/syuan/library/java/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/home/syuan/library/java/config_linux',
    '-data', vim.fn.expand('$HOME/.cache/jdtls-workspace').. workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  capabilities = capabilities
}
require('jdtls').start_or_attach(config)

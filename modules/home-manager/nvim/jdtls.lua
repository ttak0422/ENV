local jdtls = require("jdtls")
local root = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
local full_path = vim.fn.fnamemodify(root, ":p:h"):gsub("/", "_")
local workspace = os.getenv("HOME") .. "/.local/share/eclipse/" .. full_path

local bundles = {
  vim.fn.glob(args.java_debug_jar_pattern, 1),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(args.java_test_jar_pattern, 1), "\n"))

jdtls.jol_path = args.jol_jar

local config = {
  on_attach = function(client, bufnr)
    dofile(args.on_attach_path)(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.setup").add_commands()
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
  capabilities = dofile(args.capabilities_path),
  cmd = {
    args.java_bin,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dosgi.sharedConfiguration.area=" .. args.jdtls_config,
    "-Dosgi.sharedConfiguration.area.readOnly=true",
    "-Dosgi.checkConfiguration=true",
    "-Dosgi.configuration.c:ascaded=true",
    "-Dlog.protocol=true",
    "-Dlog.level=OFF",
    "-noverify",
    "-Xms1G",
    "-Xmx12G",
    "-Xlog:disable",
    "-javaagent:" .. args.lombok_jar,
    "-jar",
    vim.fn.glob(args.jdtls_jar_pattern),
    "--add-modules=ALL-SYSTEM",
    "--add-opens java.base/java.util=ALL-UNNAMED",
    "--add-opens java.base/java.lang=ALL-UNNAMED",
    "-data",
    workspace,
  },
  root_dir = root,
  settings = dofile(args.jdtls_settings_path)(args.runtimes),
  init_options = {
    bundles = bundles,
  },
  flags = {
    allow_incremental_sync = true,
  },
  handlers = {
    ["language/status"] = function() end,
  },
}

jdtls.start_or_attach(config)

vim.api.nvim_create_augroup("jdtls_lsp", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "java" },
  callback = function()
    jdtls.start_or_attach(config)
  end,
})
vim.api.nvim_create_user_command("JdtTestClass", "lua require('jdtls').test_class()", {})
vim.api.nvim_create_user_command("JdtTestNearestMethod", "lua require('jdtls').test_nearest_method()", {})

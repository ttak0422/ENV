return function(opt)
  local jdtls = require("jdtls")
  local root = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
  local workspace = os.getenv("HOME") .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root, ":p:h:t")
  local config = {
    on_attach = opt.on_attach,
    capabilities = opt.capabilities,
    cmd = {
      opt.java_bin,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      --"-Dosgi.sharedConfiguration.area=${pkgs.jdt-language-server}/share/config",
      "-Dosgi.sharedConfiguration.area=" .. opt.jdtls_config,
      "-Dosgi.sharedConfiguration.area.readOnly=true",
      "-Dosgi.checkConfiguration=true",
      "-Dosgi.configuration.c:ascaded=true",
      "-Dlog.protocol=true",
      "-Dlog.level=OFF",
      "-XX:+UseG1GC",
      "-XX:GCTimeRatio=4",
      "-XX:AdaptiveSizePolicyWeight=90",
      "-XX:MaxGCPauseMillis=200",
      "-Dsun.zip.disableMemoryMapping=true",
      "-Xms1G",
      "-Xmx12G",
      "-Xlog:disable",
      -- "-javaagent:${pkgs.lombok}/share/java/lombok.jar",
      "-javaagent:" .. opt.lombok_jar,
      "-jar",
      -- vim.fn.glob("${pkgs.jdt-language-server}/share/java/plugins/org.eclipse.equinox.launcher_*.jar"),
      opt.jdtls_jar,
      "--add-modules=ALL-SYSTEM",
      "--add-opens java.base/java.util=ALL-UNNAMED",
      "--add-opens java.base/java.lang=ALL-UNNAMED",
      "-data",
      workspace,
    },
    root_dir = root,
    settings = opt.jdtls_settings,
    init_options = {
      bundles = {
        opt.java_debug_jar,
      },
    },
    flags = {
      debounce_text_changes = 500,
      allow_incremental_sync = false,
    },
    handlers = {
      ["client/registerCapability"] = function(_, _, _, _)
        return {
          result = nil,
          error = nil,
        }
      end,
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
end

-- https://github.com/eclipse/eclipse.jdt.ls/blob/master/org.eclipse.jdt.ls.core/src/org/eclipse/jdt/ls/core/internal/preferences/Preferences.java
return function(runtimes)
  return
    {
      java = {
        configuration = {
          runtimes = runtimes or {},
          updateBuildConfiguration = "automatic",
        },
        import = {
          gradle = {
            offline = {
              enabled = true,
            },
          },
          maven = {
            offline = {
              enabled = true,
            },
          },
        },
        maven = {
          downloadSources = true,
          updateSnapshots = true,
        },
        eclipse = {
          downloadSources = true,
        },
        format = {
          enabled = false, -- use google java format
        },
        referencesCodeLens = {
          enabled = false,
        },
        implementationsCodeLens = {
          enabled = false,
        },
        signatureHelp = {
          enabled = true,
          description = {
            enabled = true,
          },
        },
        completion = {
          favoriteStaticMembers = {
            "org.assertj.core.api.Assertions.assertThat",
            "org.assertj.core.api.Assertions.assertThatCode",
            "org.junit.jupiter.params.provider.Arguments.arguments",
            "org.mockito.Mockito.*",
          },
        },
        autobuild = {
          enabled = true,
        },
        errors = {
          incompleteClasspath = {
            severity = "ignore",
          },
        },
      },
    }
end

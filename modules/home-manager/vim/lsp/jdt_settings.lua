return function(runtimes)
  return
    {
      ["java.import.gradle.enabled"] = true,
      ["java.import.gradle.offline.enabled"] = true,
      ["java.import.maven.enabled"] = true,
      ["java.import.maven.offline.enabled"] = true,
      ["java.import.exclusions"] = {
        "**/node_modules/**",
        "**/.metadata/**",
        "**/archetype-resources/**",
        "**/META-INF/maven/**",
      },
      ["java.maven.downloadSources"] = true,
      ["java.maven.updateSnapshots"] = true,
      ["java.inlayHints.parameterNames.enabled"] = "literals",
      ["java.eclipse.downloadSources"] = true,
      ["java.configuration.runtimes"] = runtimes or {},
      ["java.configuration.updateBuildConfiguration"] = "automatic",
      ["java.format.enabled"] = false, -- use google java format
      ["java.referencesCodeLens.enabled"] = false,
      ["java.implementationsCodeLens.enabled"] = false,
      ["java.signatureHelp.enabled"] = false,
      ["java.signatureHelp.description.enabled"] = false,
      ["java.completion.enabled"] = true,
      ["java.completion.postfix.enabled"] = false,
      ["java.completion.guessMethodArguments"] = false,
      ["java.completion.favoriteStaticMembers"] = {
        "org.assertj.core.api.Assertions.assertThat",
        "org.assertj.core.api.Assertions.assertThatCode",
        "org.junit.jupiter.params.provider.Arguments.arguments",
        "org.mockito.Mockito.*",
      },
      ["java.trace.server"] = "off",
      ["java.autobuild.enabled"] = true,
      ["java.errors.incompleteClasspath.severity"] = "warning",
      ["java.completion.importOrder"] = {
        "#",
        "java",
        "javax",
        "jakarta",
        "org",
        "com",
      },
      ["java.completion.filteredTypes"] = {
        "java.awt.*",
        "com.sun.*",
        "sun.*",
        "jdk.*",
        "org.graalvm.*",
        "io.micrometer.shaded.*",
      },
    }
end

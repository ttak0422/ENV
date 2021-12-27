{ shellType ? "bash", ... }: {
  shellAliases = {
    ".." = "cd ..";
    "g" = if shellType == "fish" then
      "cd (ghq root)'/'(ghq list | fzf)"
    else
      "cd $(ghq root)/$(ghq list | fzf)";
    "gg" = "ghq get";
    "cat" = "bat";
    "ls" = "exa";
    "tree" = "exa -T";
  };
  abbrevs = {
    static = { };
    eval = { };
  };
}

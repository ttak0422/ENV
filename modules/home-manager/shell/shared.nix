{ shellType ? "bash", ... }: {
  shellAliases = { ".." = "cd .."; };
  abbrevs = {
    static = { };
    eval = { };
  };
}

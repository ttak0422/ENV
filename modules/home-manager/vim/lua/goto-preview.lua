require('goto-preview').setup {
  width = 120;
  height = 15;
  border = {"┌", "─" ,"┐", "│", "┘", "─", "└", "│"};
  -- gpd: definition-
  -- gpi: implementation
  -- gP: close all
  -- gpr: reference
  default_mappings = true;
  debug = false;
  opacity = nil;
  resizing_mappings = false;
  post_open_hook = nil;
  focus_on_open = true;
  dismiss_on_move = false;
  force_close = true,
  bufhidden = "wipe",
}


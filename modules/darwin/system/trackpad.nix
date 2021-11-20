{ config, pkgs, lib, ... }: {
  system.defaults.trackpad = {
    # タップでクリック
    Clicking = true;
    # タップでドラッグ
    Dragging = true;
  };
}

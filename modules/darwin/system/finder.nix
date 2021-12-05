{ config, pkgs, lib, ... }: {
  system.defaults.finder = {
    # 拡張子を表示
    AppleShowAllExtensions = true;
    # 拡張子の変更で警告しない
    FXEnableExtensionChangeWarning = false;
  };
}

{ config, pkgs, lib, ... }: {
  system.defaults.NSGlobalDomain = {
    # Fnキーをファンクションとして扱う
    "com.apple.keyboard.fnState" = true;
    # " を勝手に変換しないように
    NSAutomaticDashSubstitutionEnabled = false;
    # ' を勝手に変換しないように
    NSAutomaticQuoteSubstitutionEnabled = false;
    # 特殊キーを無視 (キーの長押し)
    ApplePressAndHoldEnabled = false;
    # Finderに
    AppleShowAllExtensions = true;
  };
}

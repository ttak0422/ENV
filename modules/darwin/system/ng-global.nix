{ config, pkgs, lib, ... }: {
  system.defaults.NSGlobalDomain = {
    # Fnキーをファンクションとして扱う
    "com.apple.keyboard.fnState" = true;
    # disable natural scroll
    "com.apple.swipescrolldirection" = false;
    # " を勝手に変換しないように
    NSAutomaticDashSubstitutionEnabled = false;
    # ' を勝手に変換しないように
    NSAutomaticQuoteSubstitutionEnabled = false;
    # 自動大文字化させない
    NSAutomaticCapitalizationEnabled = false;
    # 特殊キーを無視 (キーの長押し)
    ApplePressAndHoldEnabled = false;
    # 拡張子表示
    AppleShowAllExtensions = true;
    # 画しファイル表示
    AppleShowAllFiles = true;
    # keyboardレスポンス改善
    InitialKeyRepeat = 15;
    # keyboard連続入力改善
    KeyRepeat = 2;
    # disable window animation
    NSAutomaticWindowAnimationsEnabled = false;
  };
}

{ config, pkgs, lib, ... }: {
  home = {
    packages = with pkgs; [ rustup ];
    file = {
      ".cargo/config".text = ''
        [target.x86_64-apple-darwin]
        rustflags = [
          "-C", "link-arg=-undefined",
          "-C", "link-arg=dynamic_lookup",
        ]

        [target.aarch64-apple-darwin]
        rustflags = [
          "-C", "link-arg=-undefined",
          "-C", "link-arg=dynamic_lookup",
        ]
      '';
    };
  };
}

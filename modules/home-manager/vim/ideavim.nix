{ config, pkgs, lib, ... }:
let
  inherit (lib.strings) fileContents;
  extraConfig = ''
    ${fileContents ./vim/tiny.vim}

    # https://github.com/AlexPl292/IdeaVim-EasyMotion
    set easymotion
    map <Leader>s <Plug>(easymotion-s)
    map <Leader>S <Plug>(easymotion-s2)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
  '';
in { home.file = { ".ideavimrc".text = extraConfig; }; }

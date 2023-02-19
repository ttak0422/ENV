{ config, pkgs, lib, ... }:
let
  tigrc = ''
    set main-view = id date author:email-user commit-title:graph=yes,refs=yes
    set main-view-date = custom
    set main-view-date-format = "%y/%m/%d %H:%M"
    set blame-view  = date:default author:email-user id:yes,color line-number:yes,interval=1 text
    set pager-view  = line-number:yes,interval=1 text
    set stage-view  = line-number:yes,interval=1 text
    set log-view    = line-number:yes,interval=1 text
    set blob-view   = line-number:yes,interval=1 text
    set diff-view   = line-number:yes,interval=1 text:yes,commit-title-overflow=no

    bind main R !git rebase -i %(commit)

    bind diff R !git rebase -i %(commit)

    bind status C >git commit
    bind status e >nvr -s -l %(file)

    bind stage e >nvr -s -l %(file)
  '';
in {
  home = {
    packages = with pkgs; [ tig ];
    file.".tigrc".text = tigrc;
  };
}

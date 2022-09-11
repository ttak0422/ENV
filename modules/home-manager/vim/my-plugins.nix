{ pkgs, lib, stdenv }:
let
  inherit (stdenv) mkDerivation;
  inherit (pkgs) fetchFromGitHub fetchFromGitLab;
  inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
in {
  serenade = buildVimPluginFrom2Nix {
    pname = "serenade";
    version = "2022-06-17";
    src = fetchFromGitHub {
      owner = "b4skyx";
      repo = "serenade";
      rev = "3a27c50059ec0d81554473c6cbc267b233f2d131";
      sha256 = "0p12v6gy7j21l2nxx7931mq43gv5hyqii1wbpr9i4biabmc4qr84";
    };
  };

  alpha-nvim = buildVimPluginFrom2Nix {
    pname = "alpha-nvim";
    version = "2022-06-17";
    src = fetchFromGitHub {
      owner = "goolord";
      repo = "alpha-nvim";
      rev = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94";
      sha256 = "0w4864v6lgyzjckrsim8si9d6g7w979n81y96hx2h840xgcj22iw";
    };
  };

  denops-vim = buildVimPluginFrom2Nix {
    pname = "denops.vim";
    version = "20220613";
    src = fetchFromGitHub {
      owner = "vim-denops";
      repo = "denops.vim";
      rev = "53f25d7f2d20c7064a91db4d9129b589a66cda3f";
      sha256 = "02n9qm0c00s1siqhbnizycnzq4rj7klgh1yqcbd2hpyjjmh26bi4";
    };
  };

  skkeleton = buildVimPluginFrom2Nix {
    pname = "skkeleton";
    version = "20220711";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "42f81f8b32f282b77cdabbc8641e552ba20a57ff";
      sha256 = "01vjc30cwwk3rhmbli2qcki2r5ndypp984sqhqncv5j5fswf5b5g";
    };
  };

  skkeleton_indicator-nvim = buildVimPluginFrom2Nix {
    pname = "skkeleton_indicator.nvim";
    version = "20220617";
    src = fetchFromGitHub {
      owner = "delphinus";
      repo = "skkeleton_indicator.nvim";
      rev = "7630bb99ba99f73e07d17f711e50aab24a5417ce";
      sha256 = "0xjrhcgjm38a0dx42n21pwrwclm3ls22cr1a85rgslk7gjkip185";
    };
  };

  cmp-skkeleton = buildVimPluginFrom2Nix {
    pname = "cmp-skkeleton";
    version = "20220629";
    src = fetchFromGitHub {
      owner = "rinx";
      repo = "cmp-skkeleton";
      rev = "f03f3019d2afd6885878ffd6471bb3983b4aacc9";
      sha256 = "0d0iajdkplw3h9cv9hpjw6m1pilv6waf3swzsygda31nbn48r6v4";
    };
  };

  dim-lua = buildVimPluginFrom2Nix {
    pname = "dim.lua";
    version = "20220617";
    src = fetchFromGitHub {
      owner = "NarutoXY";
      repo = "dim.lua";
      rev = "53476b9db9309198ac637b90f93f178ef46e6984";
      sha256 = "0ajcczddrcgx67lfszcpba4jmjcy7pp21vvgnnwrwr48bc89f5gc";
    };
  };

  zoomwintab-vim = buildVimPluginFrom2Nix {
    pname = "";
    version = "20220617";
    src = fetchFromGitHub {
      owner = "troydm";
      repo = "zoomwintab.vim";
      rev = "7a354f3f0aa7807d822c03c8c24dc6c1cced9d3c";
      sha256 = "18b9c90nrbia3bdx9liznkm05pr7qlya7fdllqnnmpb4v047c06f";
    };
  };

  winresizer = buildVimPluginFrom2Nix {
    pname = "winresizer";
    version = "20220617";
    src = fetchFromGitHub {
      owner = "simeji";
      repo = "winresizer";
      rev = "9dc9899cedf84d78b93263b1fdb105b37c54c7b5";
      sha256 = "0l6vj5bfxg0jcxnnknla4mxlzcrdc7z3d0f8adv734ylwil1wgc5";
    };
  };

  chowcho-nvim = buildVimPluginFrom2Nix {
    pname = "chowcho.nvim";
    version = "2022-09-11";
    src = fetchFromGitHub {
      owner = "tkmpypy";
      repo = "chowcho.nvim";
      rev = "0edaed82ebc8f38c0a14a3d776baddb4d134cbda";
      sha256 = "1drqpncw6x0xzbrx2pq68502gs7n54c6kyydnrmycgl7sl57d4j9";
    };
  };

  fzy-lua-native = buildVimPluginFrom2Nix {
    pname = "fzy-lua-native";
    version = "20220627";
    src = fetchFromGitHub {
      owner = "romgrk";
      repo = "fzy-lua-native";
      rev = "aa00feb01128c4d279c8471898e15898e75d5df5";
      sha256 = "03sdsbw0sg8l1hi469zd8fdxi8aiwf5h3pq3dsyp2pprkj65sf95";
    };
  };

  nvim-lsp-installer = buildVimPluginFrom2Nix {
    pname = "nvim-lsp-installer";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "williamboman";
      repo = "nvim-lsp-installer";
      rev = "fbd957fc4e7a054c42d37632cdb6057b309e7853";
      sha256 = "0bilpd3n192wn3vk7mxmwavq3ai1yjcanfhhq3m5shpl0l67cqfa";
    };
  };

  lspsaga-nvim = buildVimPluginFrom2Nix {
    pname = "lspsaga.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "a520a3e17bf11bb09e00a94ddd6fa965fa1ec232";
      sha256 = "01rizlak7rf0ngzsdr49lzhkmliihcw3bymm5cg45hypznai9900";
    };
  };

  spaceless-nvim = buildVimPluginFrom2Nix {
    pname = "spaceless.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "lewis6991";
      repo = "spaceless.nvim";
      rev = "4012c778cf8973379cc4e7e52d2260b15d390462";
      sha256 = "1d677f8v20k1fw4gs1a9zbhfjgn142i6gnjlf89jmv00fyj1l9ji";
    };
  };

  hlargs-nvim = buildVimPluginFrom2Nix {
    pname = "hlargs.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "m-demare";
      repo = "hlargs.nvim";
      rev = "02a4cd102727a53553f6e516b9e1ed2f8d7dee67";
      sha256 = "0nnrcnwqfza3z5gi81xj90wnpkjhcxjm4lc9055j1mbwyjnwjyhf";
    };
  };

  cmp-nvim-lsp-signature-help = buildVimPluginFrom2Nix {
    pname = "cmp-nvim-lsp-signature-help";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp-signature-help";
      rev = "8014f6d120f72fe0a135025c4d41e3fe41fd411b";
      sha256 = "1k61aw9mp012h625jqrf311vnsm2rg27k08lxa4nv8kp6nk7il29";
    };
  };

  telescope-live-grep-args-nvim = buildVimPluginFrom2Nix {
    pname = "telescope-live-grep-args.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-live-grep-args.nvim";
      rev = "77d53b25ef6eb080845b1dac8337cac0be6b9114";
      sha256 = "0cajll7npd6i2w9vwghm59bywkwflqrnyj4aa496yza9cl4dlx44";
    };
  };

  telescope-fzf-native-nvim = mkDerivation {
    pname = "telescope-fzf-native.nvim";
    buildInputs = with pkgs; [ gcc ];
    version = "20220628";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "telescope-fzf-native.nvim";
      rev = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6";
      sha256 = "1ssznk16fhnqsp2kwff48ccbrgw2cbaxjhbj6wzap9cbw78kxpf9";
    };
    installPhase = ''
      mkdir $out
      cp -r ./* $out
    '';
  };

  filetype-nvim = buildVimPluginFrom2Nix {
    pname = "filetype.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "nathom";
      repo = "filetype.nvim";
      rev = "b522628a45a17d58fc0073ffd64f9dc9530a8027";
      sha256 = "0l2cg7r78qbsbc6n5cvwl5m5lrzyfvazs5z3gf54hspw120nzr87";
    };
  };

  flare-nvim = buildVimPluginFrom2Nix {
    pname = "flare.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "stonelasley";
      repo = "flare.nvim";
      rev = "66792f185d974a26f60e44d2d94aff11dada643b";
      sha256 = "0c1mzskswjz6b6if69bhcak3gx8609pwvaqwh2wx9kw4v64kjx2v";
    };
  };

  legendary-nvim = buildVimPluginFrom2Nix {
    pname = "legendary.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "mrjones2014";
      repo = "legendary.nvim";
      rev = "3d6cde24296b017412bf8801db6e6777478682eb";
      sha256 = "16jyyrm7gij4djdg1hlp05v6x053f0cdjzync741di31fbnnjcy5";
    };
  };

  telescope-command-palette.nvim = buildVimPluginFrom2Nix {
    pname = "telescope-command-palette.nvim";
    version = "20220628";
    src = fetchFromGitHub {
      owner = "LinArcX";
      repo = "telescope-command-palette.nvim";
      rev = "1944d6312b29a0b41531ea3cf3912f03e4eb1705";
      sha256 = "04mvffc813v783jhvq6ng8x4n2wp7mi96g8mmrxi3a7a8h84qh53";
    };
  };

  dash-nvim = buildVimPluginFrom2Nix {
    pname = "dash.nvim";
    version = "20220621";
    src = fetchFromGitHub {
      owner = "jbyuki";
      repo = "dash.nvim";
      rev = "2165c473ac6b7b018059ac4dc0a6a301d4841e1e";
      sha256 = "055rw3qlaashbvl67wpmvq8b0d1d6y3x0pkm15wn13imyxivb5a9";
    };
  };

  telescope-command-palette-nvim = buildVimPluginFrom2Nix {
    pname = "telescope-command-palette.nvim";
    version = "20220622";
    src = fetchFromGitHub {
      owner = "LinArcX";
      repo = "telescope-command-palette.nvim";
      rev = "1944d6312b29a0b41531ea3cf3912f03e4eb1705";
      sha256 = "04mvffc813v783jhvq6ng8x4n2wp7mi96g8mmrxi3a7a8h84qh53";
    };
  };

  nvim-transparent = buildVimPluginFrom2Nix {
    pname = "nvim-transparent";
    version = "20220622";
    src = fetchFromGitHub {
      owner = "xiyaowong";
      repo = "nvim-transparent";
      rev = "ed488bee61d544f9a52516c661f5df493253a1b4";
      sha256 = "08fnbqb10zxc6qwiswnqa5xf9g8k9q8pg5mwrl2ww2qcxnxbfw1p";
    };
  };

  org-bullets-nvim = buildVimPluginFrom2Nix {
    pname = "org-bullets.nvim";
    version = "20220622";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "org-bullets.nvim";
      rev = "8a9eccd664a3b670fbde97059f8376c869797284";
      sha256 = "1x2gnylj52d0d0g2739iw8m7b9fsdxvpr74r86rj7zl9gigbqf7l";
    };
  };

  headlines-nvim = buildVimPluginFrom2Nix {
    pname = "headlines.nvim";
    version = "20220622";
    src = fetchFromGitHub {
      owner = "lukas-reineke";
      repo = "headlines.nvim";
      rev = "347ef0371451d9bfbf010c6743fb74997b5b9a80";
      sha256 = "19696gygnwy52rkr4s8pbshnirx3xgar7wzihnyjnm6b28ld41ay";
    };
  };

  mdeval-nvim = buildVimPluginFrom2Nix {
    pname = "mdeval.nvim";
    version = "20220622";
    src = fetchFromGitHub {
      owner = "jubnzv";
      repo = "mdeval.nvim";
      rev = "b2beafe64dc84327604e5b5d86bb212b479fda07";
      sha256 = "1i6sk6hc9xhbs6g0hd3ychpqvs64vd6rxigv6dg9xyxqd1zvbaaq";
    };
  };

  incline-nvim = buildVimPluginFrom2Nix {
    pname = "incline.nvim";
    version = "20220622";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "incline.nvim";
      rev = "a43a25047f267b9526f17d7fcde176dfb5f872bd";
      sha256 = "1466ipj96nbc8548mjmkkhbf9wbs7m7x0frblxz8b2n2j89annbm";
    };
  };

  incline-nvim-pr = buildVimPluginFrom2Nix {
    pname = "incline.nvim";
    version = "2022-08-06";
    src = fetchFromGitHub {
      owner = "deresmos";
      repo = "incline.nvim";
      rev = "44d4e6f4dcf2f98cf7b62a14e3c10749fc5c6e35";
      sha256 = "0aygnczz0ysdhb63dvxbfa1zd0pd5ynj8c1mk2mf9jhmhwmrjyd1";
    };
  };

  orgmode = buildVimPluginFrom2Nix {
    pname = "orgmode";
    version = "20220626";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "orgmode";
      rev = "3186ac3805ce9726c85a6ebdda741c33148f6535";
      sha256 = "126i2mi2p0230i44wvf7w6fa5fz2plslc0607zi439k63g1frk2y";
    };
  };

  nvim-treesitter = buildVimPluginFrom2Nix {
    pname = "nvim-treesitter";
    version = "20220627";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "b7fbf9ed2d9c9a93d24514f4b8d04de87538dc42";
      sha256 = "00rcdzwpriifb48i7r6fnpigrj1mqfj31j6yj71lpfy7s10cxjcv";
    };
  };

  neofsharp-vim = buildVimPluginFrom2Nix {
    pname = "neofsharp.vim";
    version = "20220710";
    src = fetchFromGitHub {
      owner = "adelarsq";
      repo = "neofsharp.vim";
      rev = "5df2f3a767df5a3b1b096e6cad67f55e24cb4033";
      sha256 = "1rkh9mcyjkiph0lfgal60ishkqmr46b0qswi62j4wnpym3z714z7";
    };
  };

  git-conflict-nvim = buildVimPluginFrom2Nix {
    pname = "git-conflict.nvim";
    version = "2022-08-03";
    src = fetchFromGitHub {
      owner = "akinsho";
      repo = "git-conflict.nvim";
      rev = "80bc8931d4ed8c8c4d289a08e1838fcf4741408d";
      sha256 = "07zk1fh1ira2ynfxql1c7z3qimp0wkl7dq7libnjgzca6a7qc4ml";
    };
  };

  fine-cmdline-nvim = buildVimPluginFrom2Nix {
    pname = "fine-cmdline.nvim";
    version = "2022-08-06";
    src = fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "fine-cmdline.nvim";
      rev = "ead2b85e455eacde10469a8fcf1a717822d2bb9a";
      sha256 = "1rdr7w527l85pr0vhcpyx3c0z1acln9g1s5hnvf5hccimg7hg9ni";
    };
  };

  themer-lua = buildVimPluginFrom2Nix {
    pname = "themer-lua";
    version = "2022-08-07";
    src = fetchFromGitHub {
      owner = "ThemerCorp";
      repo = "themer.lua";
      rev = "a3d16aa7f478088545466991cf1d89cf26066382";
      sha256 = "0rrnsvx59nkz47b6hvvgir51jk3kks5w48x837l8inc9751j18n3";
    };
  };

  vim-migemo = buildVimPluginFrom2Nix {
    pname = "vim-migemo";
    version = "2022-09-03";
    src = fetchFromGitHub {
      owner = "haya14busa";
      repo = "vim-migemo";
      rev = "9c83047985c3c141fef55a38ee525ff7ab4ed415";
      sha256 = "01qb69dlh1fs5532iv8rmq9ly27z9xjmr4qgppswrqsis99sp53x";
    };
  };

  migemo-search = buildVimPluginFrom2Nix {
    pname = "migemo-search";
    version = "2022-09-04";
    src = fetchFromGitHub {
      owner = "rhysd";
      repo = "migemo-search.vim";
      rev = "b44696e0adf1e82f2eeacd7f3f3e745e46a0ee31";
      sha256 = "1c2rjkk1761cspx2vilcd2dzynsrjvywg2ppr0jyv0dkyxcpc398";
    };
  };

  nvim-dd = buildVimPluginFrom2Nix {
    pname = "nvim-dd";
    version = "2022-09-11";
    src = fetchFromGitLab {
      owner = "yorickpeterse";
      repo = "nvim-dd";
      rev = "4ab78f8c9759db3416ad155d5859c91e7bf3f427";
      sha256 = "0mdr9sx34xmydwjnyz6gkd9ingayqqg0w34yvvni3408y73i1i27";
    };
  };
}

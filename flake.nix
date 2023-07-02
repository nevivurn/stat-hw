{
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # nixpkgs#noto-fonts-cjk-sans uses TTC fonts, but luatex / fontspec /
        # luaotfload doesn't seem to like it
        noto-sans-cjk-kr = pkgs.stdenvNoCC.mkDerivation {
          pname = "noto-sans-cjk-kr";
          version = "2.004";

          src = pkgs.fetchFromGitHub {
            owner = "googlefonts";
            repo = "noto-cjk";
            rev = "Sans2.004";
            sha256 = "sha256-waWX2yk4glZxGVog7OfapON8V+hgvGO0E/RKxnhVfzs=";
            sparseCheckout = [ "Sans/OTF/Korean" ];
          };

          installPhase = ''
            install -m444 -Dt $out/share/fonts/opentype/noto-cjk Sans/OTF/Korean/*.otf
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];

          nativeBuildInputs = with pkgs; [
          ];

          shellHook = ''
            export TEXMFHOME=.tmp/home
            export TEXMFVAR=.tmp/var
            export TEXMFCONFIG=.tmp/config
          '';
          env.OSFONTDIR = "${noto-sans-cjk-kr}/share/fonts";
        };

        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "stat-hw";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            (texlive.combine {
              inherit (texlive) scheme-small
                catchfile
                cjk-ko
                luatexko
                noto
                svg
                transparent
                trimspaces;
            })
            (python3.withPackages (ps: with ps; [ matplotlib ]))
            inkscape
          ];

          preBuild = ''
            export TEXMFHOME=$TMPDIR/home
            export TEXMFVAR=$TMPDIR/var
            export TEXMFCONFIG=$TMPDIR/config
          '';
          env.OSFONTDIR = "${noto-sans-cjk-kr}/share/fonts";

          makeFlags = [ "PREFIX=$(out)" ];
        };
      });
}


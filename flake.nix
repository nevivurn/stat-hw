{
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];

          shellHook = ''
            export TEXMFHOME=.tmp/home
            export TEXMFVAR=.tmp/var
            export TEXMFCONFIG=.tmp/config
          '';
          env.OSFONTDIR = "${pkgs.nanum}/share/fonts";
        };

        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "stat-hw";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            (texlive.combine {
              inherit (texlive) scheme-small
                catchfile
                cjk-ko
                enumitem
                luatexko
                svg
                transparent
                trimspaces;
            })
            (python3.withPackages (ps: with ps; [ matplotlib scipy ]))
            inkscape
          ];

          preBuild = ''
            export TEXMFHOME=$TMPDIR/home
            export TEXMFVAR=$TMPDIR/var
            export TEXMFCONFIG=$TMPDIR/config
          '';
          env.OSFONTDIR = "${pkgs.nanum}/share/fonts";

          enableParallelBuilding = true;

          makeFlags = [ "PREFIX=$(out)" ];
        };
      });
}


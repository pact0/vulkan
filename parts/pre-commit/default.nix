{inputs, ...}: {
  imports = [
    inputs.git-hooks.flakeModule

    ./hooks/exiftool.nix
    ./hooks/prettier.nix
  ];

  perSystem = {
    pkgs,
    lib,
    ...
  }: let
    inherit (import ./utils.nix {inherit pkgs lib;}) excludes mkHook;
  in {
    pre-commit = {
      check.enable = true;

      settings = {
        # inherit the global exclude list
        inherit excludes;

        # hooks that we want to enable
        hooks = {
          luacheck = mkHook "luacheck" {enable = true;};

          treefmt = mkHook "treefmt" {enable = true;};

          alejandra = mkHook "Alejandra" {
            enable = true;
          };

          actionlint = mkHook "actionlint" {
            enable = true;
            files = "^.github/workflows/"; # only trigger in .github/workflows
          };

          lychee = mkHook "lychee" {
            enable = true;
            excludes = ["^(?!.*\.md$).*"]; # ignore non-markdown
          };

          editorconfig-checker = mkHook "editorconfig" {
            enable = false;
            always_run = true;
          };

          commitizen = mkHook "commitizen" {
            enable = true;
          };

          # clang-tidy = mkHook "clang-tidy" {
          #   enable = true;
          #   excludes = ["build/.*"];
          # };

          deadnix = mkHook "deadnix" {
            enable = true;
            settings = {
              edit = true;
            };
          };
        };
      };
    };
  };
}

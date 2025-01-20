{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "Cpp project shell";
      meta.description = ''
        Cpp project shell.
      '';

      # Set up pre-commit hooks when user enters the shell.
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';

      # Tell Direnv to shut up.
      DIRENV_LOG_FORMAT = "";

      # Receive packages from treefmt's configured devShell.
      inputsFrom = [config.treefmt.build.devShell];
      packages =
        [
          # Packages provided by flake inputs
          config.treefmt.build.wrapper # Quick formatting tree-wide with `treefmt`
          # Packages from nixpkgs, for Nix, Flakes or local tools.
          pkgs.git # flakes require Git to be installed, since this repo is version controlled

          # node
          pkgs.pnpm
          pkgs.nodejs_22
        ]
        ++ (with pkgs; [
          cmake
          clang
          clang-tools
          cmake
          codespell
          conan
          cppcheck
          doxygen
          gtest
          lcov
          vcpkg
          vcpkg-tool
          ninja
          alsa-utils

          vulkan-loader
          glslang
          vulkan-headers
          vulkan-loader
          vulkan-validation-layers
          vulkan-tools
          vulkan-volk
          mesa
          SDL2
          SDL2_sound
          xorg.libXext

          wayland-scanner
          wayland-protocols

          egl-wayland

          guile-sdl2
          jazz2
          SDL2_ttf
          SDL2_net
          SDL2_gfx
          SDL2_sound
          SDL2_mixer
          SDL2_image

          wayland
          libxkbcommon
          pkg-config
          libGL

          SDL2
          # llvmPackages.clang-unwrapped
          libcxx
          libevdev
          lld
        ]);
    };
  };
}

{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "main";
  version = "1.0";

  src = ../../src;

  nativeBuildInputs = with pkgs; [
    cmake
    clang
    clang-tools

    # vulkan-loader
    # glslang
    # vulkan-headers
    # vulkan-loader
    # vulkan-validation-layers
    # vulkan-tools
    # vulkan-volk
    # mesa
    SDL2
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Debug"
  ];

  buildPhase = ''
    cmake -B build -S $src -DCMAKE_INSTALL_PREFIX=$out
    cmake --build build
  '';

  installPhase = ''
    mkdir -p $out/bin
     cp -r build/* $out/bin/
     # cmake --install build --prefix $out
  '';

  meta = with pkgs.lib; {
    description = "Main project build";
    license = licenses.mit;
    maintainers = [maintainers.yourname];
    platforms = platforms.linux;
  };
}

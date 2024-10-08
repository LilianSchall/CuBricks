{pkgs ? import <nixpkgs>{}}:
pkgs.mkShell {
  name = "cuda-env-shell";
  buildInputs = with pkgs; [
    git gitRepo gnupg autoconf curl
    procps gnumake utillinux m4 gperf unzip cmake
    linuxPackages.nvidia_x11
    gcc11
    coreutils
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib pngpp tbb gbenchmark
    ncurses5 stdenv.cc binutils
    cudaPackages.cudatoolkit
    clang-tools
  ];
  shellHook = with pkgs; ''
    export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}
    export LD_LIBRARY_PATH=${linuxPackages.nvidia_x11}/lib:${ncurses5}/lib:${libkrb5}/lib:$LD_LIBRARY_PATH
    export EXTRA_LDFLAGS="-L/lib -L${linuxPackages.nvidia_x11}/lib $EXTRA_LDFLAGS"
    export EXTRA_CCFLAGS="-I/usr/include $EXTRA_CCFLAGS"
    export PATH=${pkgs.gcc11}/bin:$PATH
    export CUDAHOSTCXX=${pkgs.gcc11}/bin/g++
    export NVCC_PREPEND_FLAGS="-ccbin ${pkgs.gcc11}/bin/g++"
  '';
}

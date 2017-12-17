{ stdenv, pkgs, fetchurl }:

with pkgs;

stdenv.mkDerivation rec {
  name = "nccl-${version}";
  version = "1.3.4-1";

  src = fetchurl {
    url = "https://github.com/NVIDIA/nccl/archive/v${version}.tar.gz";
    sha256 = "117qz8zvc4r0zjd737knr482gf208v5xlwyrpaf8pcjvam2fpr0i";
  };

  nativeBuildInputs = [
    gcc5
    eject
  ];

  propagatedBuildInputs = [
    cudatoolkit8
  ];

  BUILDDIR = "./";
  PREFIX = "$out";
  CUDA_HOME = "${cudatoolkit8}";
  CUDA_LIB = "${cudatoolkit8.lib}/lib";

  postInstall = ''
    cp -r ./lib $out
    cp -r ./include $out
  '';
}

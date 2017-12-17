{ stdenv,
  pkgs,
  python ? pkgs.python3,
  pythonPackages,
  fetchPypi
}:

with pkgs;
with pythonPackages;

let
  fastrlock = callPackage ../fastrlock {};
  nccl = callPackage ../nccl {};
in

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "cupy";
  version = "4.0.0b2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "13hnw3phx1p5c0igdr1z1v5pap2rav0kcd2sdnvl1kab0r8p7yp1";
  };

  nativeBuildInputs = [
    gcc5
    python
  ];

  propagatedBuildInputs = [
    cudatoolkit8
    cudnn60_cudatoolkit80
    linuxPackages.nvidia_x11
    nccl
    fastrlock
    numpy
    six
  ];

  CFLAGS = "-I ${cudnn60_cudatoolkit80}/include -I ${nccl}/include";
  LDFLAGS = "-L ${cudnn60_cudatoolkit80}/lib -L ${nccl}/lib";
}

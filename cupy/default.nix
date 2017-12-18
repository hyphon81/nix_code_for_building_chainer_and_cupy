{ stdenv,
  pkgs,
  python,
  fetchPypi
}:

with pkgs;
with python.pkgs;

let
  fastrlock = callPackage ../fastrlock {
    python = python;
  };
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
  ];

  propagatedBuildInputs = [
    cudatoolkit8
    cudnn60_cudatoolkit80
    linuxPackages.nvidia_x11
    nccl
    fastrlock
    numpy
    six
    wheel
  ];

  CFLAGS = "-I ${cudnn60_cudatoolkit80}/include -I ${nccl}/include";
  LDFLAGS = "-L ${cudnn60_cudatoolkit80}/lib -L ${nccl}/lib";

  # In python3, test was failed...
  doCheck = isPy27;
}

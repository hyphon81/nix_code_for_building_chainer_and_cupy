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
  version = "2.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0si0ri8azxvxh3lpm4l4g60jf4nwzibi53yldbdbzb1svlqq060r";
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

  CUDA_PATH = "${cudatoolkit8}";
  CFLAGS = "-I ${cudnn60_cudatoolkit80}/include -I ${nccl}/include";
  LDFLAGS = "-L ${cudnn60_cudatoolkit80}/lib -L ${nccl}/lib";

  # In python3, test was failed...
  doCheck = isPy27;
}

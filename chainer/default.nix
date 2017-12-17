{ stdenv,
  pkgs,
  python ? pkgs.python3,
  pythonPackages,
  fetchPypi
}:

with pythonPackages;

let
  cupy = callPackage ../cupy {};
  filelock = callPackage ../filelock {};
in

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "chainer";
  version = "4.0.0b2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0r1g9s3jbkb3qkvq4r8kmykgibx79fcnyy04q350qg34fqvlkl38";
  };

  propagatedBuildInputs = [
    cupy
    filelock
    protobuf3_3
  ];
}

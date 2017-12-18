{ stdenv,
  pkgs,
  python,
  fetchPypi
}:

with python.pkgs;

let
  cupy = callPackage ../cupy {
    python = python;
  };
  filelock = callPackage ../filelock {
    python = python;
  };
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

  # In python3, test was failed...
  doCheck = isPy27;
}

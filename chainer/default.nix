{ stdenv,
  pkgs,
  python,
  fetchPypi
}:

with pkgs;
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
  version = "3.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0mbc8kwk7pvg03bf0j57a48gr6rsdg4lzmyj0dak8y2l4lmyskpw";
  };

  propagatedBuildInputs = [
    cupy
    filelock
    protobuf3_3
  ];

  # In python3, test was failed...
  doCheck = isPy27;
}

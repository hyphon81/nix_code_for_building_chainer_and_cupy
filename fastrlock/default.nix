{ stdenv, python, fetchPypi }:

with python.pkgs;

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "fastrlock";
  version = "0.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "00mr9b15d539z89ng5nf89s2ryhk90xwx95jal77ma0wslixrk5d";
  };
}

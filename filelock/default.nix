{ stdenv, python, fetchPypi }:

with python.pkgs;

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "filelock";
  version = "2.0.13";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1n67dw7np5gsy5whynyk8c46pjlr353d6j9735p5gryaszkpjl6h";
  };
}
  

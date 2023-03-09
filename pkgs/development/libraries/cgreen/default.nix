{ lib
, stdenv
, fetchFromGitHub
, cmake
}:

stdenv.mkDerivation (self: {
  pname = "cgreen";
  version = "1.6.2";

  src = fetchFromGitHub {
    owner = "cgreen-devs";
    repo = "cgreen";
    rev = self.version;
    sha256 = "sha256-beaCoyDCERb/bdKcKS7dRQHlI0auLOStu3cZr1dhubg=";
  };

  postPatch = ''
    for F in tools/discoverer_acceptance_tests.c tools/discoverer.c; do
      substituteInPlace "$F" --replace "/usr/bin/nm" "nm"
    done
  '';

  nativeBuildInputs = [ cmake ];

  meta = {
    homepage = "https://github.com/cgreen-devs/cgreen";
    description = "The Modern Unit Test and Mocking Framework for C and C++";
    license = lib.licenses.isc;
    maintainers = [ lib.maintainers.AndersonTorres ];
    platforms = lib.platforms.unix;
  };
})

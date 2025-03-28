{
  lib,
  fetchurl,
  appimageTools,
}:
appimageTools.wrapType2 rec {
  pname = "beamdogClient";
  version = "2.1.11";

  src = fetchurl {
    url = "http://client.beamdog.com/files/beamdogClient-${version}-x86_64.AppImage";
    hash = "sha256-T0M+Jnq6IaCg1oSXGT28/LlyiWDUEMTaso8qCT1N49o=";
  };

  meta = with lib; {
    description = "Beamdog client";
    longDescription = ''
      Client for installing the Beamdog games.
    '';
    homepage = "http://client.beamdog.com/";
    license = licenses.unfreeRedistributable;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

{
  lib,
  fetchurl,
  appimageTools,
  pkgs,
}:
appimageTools.wrapType2 rec {
  pname = "OpenAudible";
  version = "4.5.3";
  src = fetchurl {
    url = "https://openaudible.org/latest/OpenAudible_x86_64.AppImage";
    hash = "sha256-bFcYsi834Q1+M4tP9QSm9SKzX3XpLOK5QDSSRezLcdE=";
  };
  extraPkgs = pkgs: [
    pkgs.webkitgtk_4_1
  ];

  meta = with lib; {
    description = "OpenAudible";
    longDescription = ''
      OpenAudible is a cross-platform audiobook manager designed for Audible users.
    '';
    homepage = "https://openaudible.org/";
    license = licenses.mit;
    maintainers = [ maintainers.starlight ];
    platforms = platforms.linux;
  };
}

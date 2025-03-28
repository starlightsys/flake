{
  lib,
  fetchurl,
  appimageTools,
}:
let
  pname = "fjordlauncher";
  version = "9.2.2";

  src = fetchurl {
    url = "https://github.com/unmojang/FjordLauncher/releases/download/${version}/FjordLauncher-Linux-x86_64.AppImage";
    hash = "sha256-wDKGyLFC75Lf9HUt9Kxevn2HuJaMSR279j0nnKUu6Go=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/org.unmojang.FjordLauncher.desktop $out/share/applications/org.unmojang.FjordLauncher.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/scalable/apps/org.unmojang.FjordLauncher.svg $out/share/icons/hicolor/scalable/apps/org.unmojang.FjordLauncher.svg
  '';

  meta = with lib; {
    description = "Prism Launcher fork with support for alternative auth servers.";
    homepage = "https://github.com/unmojang/FjordLauncher";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

let
    pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
    packages = with pkgs; [
        zig
        zls

        libGL
        xorg.libX11
        xorg.libXcursor
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXinerama
        xorg.libXrandr
        xorg.libXrender
    ];
}

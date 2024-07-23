{ config, pkgs, ... }: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."nixos.local".extraConfig = ''
      reverse_proxy http://localhost:8096
    '';
  };

  nixpkgs.overlays = [
    (self: super: {
      vlc = super.vlc.override {
        libbluray = super.libbluray.override {
          withAACS = true;
          withBDplus = true;
        };
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    handbrake
    ffmpeg
    jellyfin
    jellyfin-ffmpeg
    (retroarch.override {
      cores = with libretro; [ bsnes genesis-plus-gx snes9x beetle-psx-hw ];
    })
    vlc
  ];

  services.jellyfin.enable = true;

  services.samba-wsdd.enable =
    true; # make shares visible for windows 10 clients

  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      #hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts allow = 0.0.0.0/0
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      #      public = {
      #      path = "/mnt/Shares/Public";
      #      browseable = "yes";
      #      "read only" = "no";
      #      "guest ok" = "yes";
      #      "create mask" = "0644";
      #      "directory mask" = "0755";
      #      "force user" = "username";
      #      "force group" = "groupname";
      #};
      media = {
        path = "/media";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "jellyfin";
        "force group" = "jellyfin";
      };
      mediamgmt = {
        path = "/media";
        "valid users" = "scott";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "jellyfin";
        "force group" = "jellyfin";
      };
    };
  };

  services.samba.openFirewall = true;
}

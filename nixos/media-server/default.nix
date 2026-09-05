{ pkgs, ... }:
let
  caddyWithRoute53 = pkgs.caddy.withPlugins {
    plugins = [ "github.com/caddy-dns/route53@v1.6.2" ];
    hash = "sha256-Vzp4Y9mARJrAHZ1C3x6+5zTSGiYY1l3FxIPkqK1RI30=";
  };
in
{
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
    package = caddyWithRoute53;
    virtualHosts."jellyfin.sentientmonkey.com".extraConfig = ''
      tls {
        dns route53 {
          region us-east-1
        }
      }
      reverse_proxy http://localhost:8096
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = "/etc/caddy/aws-credentials";

  environment.systemPackages = with pkgs; [
    handbrake
    ffmpeg
    jellyfin
    jellyfin-ffmpeg
    vlc
  ];

  services.jellyfin.enable = true;

  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  services.samba = {
    enable = false;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
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
}

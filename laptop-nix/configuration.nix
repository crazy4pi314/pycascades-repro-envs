{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Define your hostname.
  networking.hostName = "nixos-demo"; 

  # Enable networking
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;
  services.flatpak.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    useQtScaling = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    libinput.touchpad.naturalScrolling = true;
    libinput.mouse.naturalScrolling = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account.
  users.users.demouser = {
    isNormalUser = true;
    description = "demouser";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
        discord
        slack
        signal-desktop
        element-desktop
        hyper
    ];
  };

  home-manager.users.demouser = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];
    programs.bash.enable = true;
    programs.nushell.enable = true;
    programs.starship.enable = true;
    programs.starship.settings = {
      format = "[](purple)$username[](bg:red fg:purple)$directory[](fg:red bg:yellow)$git_branch$git_status[](fg:yellow bg:bright-blue)$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$conda[](fg:bright-blue bg:green)$docker_context[](fg:green bg:blue)$time[ ](fg:blue)";
      username = {
        show_always = true;
        style_user = "bg:purple";
        style_root = "bg:purple";
        format = "[✨]($style)";
      };
      directory = {
        style = "bg:red";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
    };
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inkscape-with-extensions
    vlc
    keepassxc
    git
    vscode
    wget
    tailscale
    nushell
    firefox
    kate
    starship
    yakuake
    zoxide
    eza
    fd
    graphviz
    obs-studio
    htop
  ];
  programs.steam.enable = true;

#----=[ Fonts ]=----#
fonts = {
  enableDefaultPackages = true;
  packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ 
      "Noto"
      "Hack"
      "FiraCode"
      "DroidSansMono" ];
    })
  ];

  fontconfig = {
    defaultFonts = {
      serif = [ "NotoSans Nerd Font Propo" ];
      sansSerif = [ "NotoSans Nerd Font Propo" ];
      monospace = [ "FiraCode Nerd Font Propo" ];
    };
  };
};
  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

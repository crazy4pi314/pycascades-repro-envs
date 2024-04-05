# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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

  networking.hostName = "venat"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

#   environment.variables.GDK_SCALE = "2";
#   environment.variables.QT_ENABLE_HIGHDPI_SCALING = "1";
#   environment.variables.QT_SCALE_FACTOR = "2";

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sckaiser = {
    isNormalUser = true;
    description = "sckaiser";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
        discord
        slack
        signal-desktop
        element-desktop
        hyper
    ];
  };

  home-manager.users.sckaiser = { pkgs, ... }: {
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

      # shell = {
      #   disabled = false;
      #   format = "$indicator";
      #   fish_indicator = "";
      #   bash_indicator = "[BASH](bright-white) ";
      #   zsh_indicator = "[ZSH](bright-white) ";
      # };
      # hostname = {
      #   style = "bright-green bold";
      #   ssh_only = true;
      # };
      # nix_shell = {
      #   symbol = "";
      #   format = "[$symbol$name]($style) ";
      #   style = "bright-purple bold";
      # };
      # git_branch = {
      #   only_attached = true;
      #   format = "[$symbol$branch]($style) ";
      #   symbol = "שׂ";
      #   style = "bright-yellow bold";
      # };
      # git_commit = {
      #   only_detached = true;
      #   format = "[ﰖ$hash]($style) ";
      #   style = "bright-yellow bold";
      # };
      # git_state = {
      #   style = "bright-purple bold";
      # };
      # git_status = {
      #   style = "bright-green bold";
      # };
      # cmd_duration = {
      #   format = "[$duration]($style) ";
      #   style = "bright-blue";
      # };
      # jobs = {
      #   style = "bright-green bold";
      # };
      # character = {
      #   success_symbol = "[\\$](bright-green bold)";
      #   error_symbol = "[\\$](bright-red bold)";
      # };
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
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    inkscape-with-extensions
    vlc
    keepassxc
    git
    vscodium
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
    ticktick
  ];
  programs.steam.enable = true;

  # fonts.fontconfig.defaultFonts = {
  #   serif = ["NotoSans Nerd Font Propo"];
  #   monospace = ["Hack Nerd Font Mono"];
  #   sansSerif = ["NotoSans Nerd Font Propo"];
  # };
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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

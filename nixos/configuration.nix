# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # services.network-manager.enable = true;
  programs.nm-applet.enable = true;
  # networking.wireless.enable = true;  
  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #  networking.wireless.enable = true;
  # networking.wireless.userControlled.enable = true;
  # networking.wireless.networks.NETIASPOT-B253F0.pskRaw= "6a749b4ca697044f510b017f2ddaefe185466913435ff2d49c78c494dadacede";
  programs.hyprland = {
    enable = true;    
    # nvidiaPatches = true;   
    xwayland.enable = true;   
  };

  # (pkgs.waybar.overrideAttrs (oldAttrs: {
  #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  # })
# ) 

 
  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware.opengl = {
   enable = true;
   driSupport = true;
   driSupport32Bit = true; 
  };
  hardware.nvidia.modesetting.enable = true;
  
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
  #  modesetting.enable = true;
   powerManagement.enable = false;
   powerManagement.finegrained = false;
   open = false ;
   nvidiaSettings = true;
   package = config.boot.kernelPackages.nvidiaPackages.stable;
  };	 
  hardware.nvidia.prime = {
   sync.enable = true;
   nvidiaBusId = "PCI:1:0:0"; 
   intelBusId = "PCI:0:1:0";
  
  };

 services.devmon.enable = true;
 services.gvfs.enable = true;
 services.udisks2.enable = true;

 # Enable networking
 # Allow NetworkManager to save passwords to disk
  
  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  time.hardwareClockInLocalTime = true;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;
  services.displayManager.sddm.wayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "pl";
    xkb.variant = "";
    # desktopManager.gnome.enable = true;
  };

  # Configure console keymap
  console.keyMap = "pl2";

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
  users.users.bartek = {
    isNormalUser = true;
    description = "Bartosz Kozlowski";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "bartek";
  
  # Install firefox.
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
    
  programs.nix-ld.package = pkgs.nix-ld-rs;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    vscode
    google-chrome
    wpa_supplicant
    networkmanager
    networkmanagerapplet
    neovim
    discord
    spotify
    #hyprland
    glib
    gsettings-desktop-schemas
    gnome.gnome-tweaks
    gnome.nautilus
    libgnome-keyring
    hyprcursor
    swaynotificationcenter
    libnotify
    eww
    swww
    kitty
    ags
    rofi-wayland
    neofetch
    dbus
    kdePackages.filelight
    htop
    blueberry
    playerctl
    showmethekey
    cbonsai
    wl-clipboard
    gh
    hyprcursor
    unzip
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    libnotify
    haskellPackages.gi-dbusmenugtk3
    steam
    logseq
    gnomeExtensions.eye-extended
   # hyprpanel
# programming language
    ripgrep
    gcc
    nodejs_22
    bun
    unityhub
    python3
    python312Packages.flask
    python312Packages.dbus-python 
    cmake
    ninja
    grim
    slurp
    go
    cargo
    impl
    gotests
    gomodifytags
    delve
    docker
    docker-compose
    dotnetCorePackages.sdk_9_0
    dotnet-sdk_8   
    cava
    jetbrains.clion
    jetbrains.goland
    jetbrains.rust-rover
    vesktop
    hyprlock
    catppuccin-cursors.mochaMauve
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    ];
     environment.variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/glib-2.0/schemas";
  #gtk.theme.package = pkgs.catppuccin-gtk;
  #gtk.theme.name = "frappe";
  fonts.packages = with pkgs; [
	cascadia-code
	font-awesome
	jetbrains-mono
	comic-mono
  ];
  programs.java = { enable = true; package = pkgs.oraclejre8; };
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  	virtualisation.docker.rootless = {
  	enable = true;
   	setSocketVariable = true;
 };
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
  system.stateVersion = "24.05"; # Did you read the comment?

}

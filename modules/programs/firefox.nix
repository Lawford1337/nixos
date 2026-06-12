{ lib, config, pkgs, ... }:
let
  cfg = config.lawford.programs.firefox;
in
{
  options.lawford.programs.firefox = {
    enable = lib.mkEnableOption "Firefox with transparency and Stylix";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      programs.firefox = {
        enable = true;
        profiles.default = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.drawInTitlebar" = true;
            "layers.acceleration.force-enabled" = true;
            "gfx.webrender.all" = true;
            "layout.css.backdrop-filter.enabled" = true;
          };
          userChrome = ''
            #main-window,
            #browser {
              background: transparent !important;
            }

            #navigator-toolbox {
              background: rgba(0, 0, 0, 0.45) !important;
              backdrop-filter: blur(12px) !important;
            }

            #nav-bar {
              background: transparent !important;
            }

            #TabsToolbar {
              background: rgba(0, 0, 0, 0.3) !important;
            }

            .tab-background {
              background: rgba(255, 255, 255, 0.08) !important;
            }

            .tab-background[selected] {
              background: rgba(255, 255, 255, 0.18) !important;
            }
          '';
          userContent = ''
            @-moz-document url("about:blank"), url("about:newtab"), url("about:home") {
              body {
                background: transparent !important;
              }
            }
          '';
        };
      };
    };
  };
}

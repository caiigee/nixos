{
  pkgs,
  ...
}:
let
  gnomeTheme = builtins.fetchGit {
    url = "https://github.com/rafaelmardojai/firefox-gnome-theme.git";
    rev = "59e3de00f01e5adb851d824cf7911bd90c31083a";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        bookmarks = {
          force = true;
          settings = [
            {
              name = "Wikipedia";
              keyword = "w";
              url = "https://en.wikipedia.org";
            }
            {
              name = "Youtube";
              keyword = "y";
              url = "https://www.youtube.com/";
            }
            {
              name = "Wiktionary";
              keyword = "wt";
              url = "https://en.wiktionary.org";
            }
            {
              name = "GitHub";
              keyword = "gh";
              url = "https://github.com";
            }
            {
              name = "Regexr";
              keyword = "re";
              url = "https://regexr.com/";
            }
            {
              name = "ILovePDF";
              keyword = "pdf";
              url = "https://www.ilovepdf.com";
            }
            {
              name = "Claude";
              keyword = "ai";
              url = "https://claude.ai/new";
            }
            {
              name = "Nextcloud";
              keyword = "nc";
              url = "https://nc.caiigee.com/index.php/apps/dashboard";
            }
            {
              name = "Home Manager Options";
              keyword = "hmo";
              url = "https://home-manager-options.extranix.com/";
            }
            {
              name = "Nix Packages";
              keyword = "np";
              url = "https://search.nixos.org/packages";
            }
            {
              name = "Nix Options";
              keyword = "no";
              url = "https://search.nixos.org/options?";
            }
            {
              name = "NixOS Wiki";
              keyword = "nw";
              url = "https://wiki.nixos.org/wiki/NixOS_Wiki";
            }
            {
              name = "Reddit";
              keyword = "r";
              url = "https://www.reddit.com";
            }
            {
              name = "TA2 Viewer";
              keyword = "ta2";
              url = "https://ta2viewer.openanatomy.org/";
            }
            {
              name = "ChatGPT";
              keyword = "gpt";
              url = "https://chatgpt.com/";
            }
            {
              name = "Latin is simple";
              keyword = "lis";
              url = "https://www.latin-is-simple.com/";
            }
            {
              name = "Anna's Archive";
              keyword = "aa";
              url = "https://annas-archive.org";
            }
            {
              name = "Proton Mail";
              keyword = "pm";
              url = "https://mail.proton.me/u/0/inbox";
            }
            {
              name = "Hyprland Wiki";
              keyword = "hw";
              url = "https://wiki.hyprland.org/";
            }
            {
              name = "Hrvatski jezični portal";
              keyword = "hjp";
              url = "https://hjp.znanje.hr/index.php?show=main";
            }
            {
              name = "Crates";
              keyword = "cr";
              url = "https://crates.io";
            }
            {
              name = "Compose sequences";
              keyword = "cs";
              url = "https://cgit.freedesktop.org/xorg/lib/libX11/plain/nls/en_US.UTF-8/Compose.pre";
            }
            {
              name = "LMS";
              keyword = "lms";
              url = "https://lms.mef.hr/e-ucenje/2024-2025/course/index.php?categoryid=1";
            }
            {
              name = "Gramatika";
              keyword = "hsg";
              url = "http://gramatika.hr/";
            }
            {
              name = "Nix manual";
              keyword = "nm";
              url = "https://nixos.org/manual/nixpkgs/unstable/";
            }
            {
              name = "Minecraft wiki";
              keyword = "mw";
              url = "https://minecraft.wiki";
            }
          ];
        };
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          proton-pass
          darkreader
          ublock-origin
          decentraleyes
        ];
        search = {
          default = "SearXNG";
          engines = {
            "Wikipedia" = {
              urls = [
                {
                  template = "https://en.wikipedia.org/wiki/Special:Search";
                  params = [
                    {
                      "name" = "search";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://en.wikipedia.org/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "w:" ];
            };
            "Wiktionary" = {
              urls = [
                {
                  template = "https://en.wiktionary.org/wiki/Special:Search";
                  params = [
                    {
                      "name" = "search";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://en.wiktionary.org/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "wt:" ];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      "name" = "channel";
                      "value" = "unstable";
                    }
                    {
                      "name" = "query";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "np:" ];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      "name" = "channel";
                      "value" = "unstable";
                    }
                    {
                      "name" = "query";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "no:" ];
            };
            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/w/index.php";
                  params = [
                    {
                      "name" = "search";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "nw:" ];
            };
            "GitHub" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      "name" = "q";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://github.githubassets.com/assets/apple-touch-icon-72x72-e090c8a282d0.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "gh:" ];
            };
            "SearXNG" = {
              urls = [
                {
                  template = "https://priv.au";
                  params = [
                    {
                      "name" = "q";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://priv.au/static/themes/simple/img/favicon.png?60321eeb6e2f478f0e5704529308c594d5924246";
              updateInterval = 24 * 60 * 60 * 1000;
            };
            "Youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      "name" = "search_query";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://www.youtube.com/s/desktop/e208051c/img/logos/favicon_144x144.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "y:" ];
            };
            "reddit" = {
              urls = [
                {
                  template = "https://www.reddit.com/search/";
                  params = [
                    {
                      "name" = "q";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://www.redditstatic.com/shreddit/assets/favicon/128x128.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "r:" ];
            };
            "Anna's Archive" = {
              urls = [
                {
                  template = "https://annas-archive.org/search";
                  params = [
                    {
                      "name" = "q";
                      "value" = "{searchTerms}";
                    }
                    {
                      "name" = "ext";
                      "value" = "epub";
                    }
                    {
                      "name" = "lang";
                      "value" = "en";
                    }
                    {
                      "name" = "sort";
                      "value" = "newest";
                    }
                  ];
                }
              ];
              icon = "https://annas-archive.org/apple-touch-icon.png?hash=d2fa3410fb1ae23ef0ab";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "aa:" ];
            };
            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      "name" = "query";
                      "value" = "{searchTerms}";
                    }
                    {
                      "name" = "release";
                      "value" = "master";
                    }
                  ];
                }
              ];
              icon = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "hmo:" ];
            };
            "Crates" = {
              urls = [
                {
                  template = "https://crates.io/search";
                  params = [
                    {
                      "name" = "q";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://crates.io/assets/cargo.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "cr:" ];
            };
            "Minecraft Wiki" = {
              urls = [
                {
                  template = "https://minecraft.wiki/w/";
                  params = [
                    {
                      "name" = "search";
                      "value" = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://minecraft.wiki/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "mw:" ];
            };
            "bing".metaData.hidden = true;
            "google".metaData.hidden = true;
            "ddg".metaData.hidden = true;
            "wikipedia".metaData.hidden = true;
          };
        };
        settings = {
          # FIREFOX GNOME THEME
          # Essential:
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          # Nonessential:
          "browser.uidensity" = 0;
          "browser.theme.dark-private-windows" = false;
          "widget.gtk.rounded-bottom-corners.enabled" = true;
          # Preferences:
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.tabsAsHeaderbar" = true;
          "gnomeTheme.oledBlack" = true;
          "gnomeTheme.systemIcons" = true;
          "gnomeTheme.noThemedIcons" = true;

          # STARTUP
          "browser.shell.checkDefaultBrowser" = false;
          # 0=blank, 1=home, 2=last visited page, 3=resume previous session.
          "browser.startup.page" = 0;
          "browser.startup.homepage" = "about:blank";
          # true=Activity Stream (default), false=blank page.
          "browser.newtabpage.enabled" = false;
          # Disable sponsored content on Firefox Home (Activity Stream):
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          # Clear default topsites:
          "browser.newtabpage.activity-stream.default.sites" = "";
          "browser.topsites.contile.enabled" = false;
          "browser.topsites.useRemoteSetting" = false;

          # GEOLOCATION
          # Disabling geolocation tracking with the OS's geolocation service:
          "geo.provider.network.url" = "";
          "geo.provider.use_gpsd" = false;
          "geo.provider.geoclue.always_high_accuracy" = false;
          "geo.provider.use_geoclue" = false;
          # Disabling region updates:
          "browser.region.network.url" = "";
          "browser.region.update.enabled" = false;

          # RECOMMENDATIONS
          # Disabling recommendation pane in about:addons (uses Google Analytics).
          "extensions.getAddons.showPane" = false;
          # Disabling recommendations in about:addons' Extensions and Themes panes.
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          # Disabling personalized Extension Recommendations in about:addons and AMO.
          "browser.discovery.enabled" = false;
          # Disabling shopping experience [FF116+]
          "browser.shopping.experience2023.enabled" = false;
          "browser.shopping.experience2023.opted" = 2;
          "browser.shopping.experience2023.active" = false;

          # TELEMETRY
          # Disabling new data submission.
          "datareporting.policy.dataSubmissionEnabled" = false;
          # Disabling Health Reports.
          "datareporting.healthreport.uploadEnabled" = false;
          # Disabling telemetry:
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data: =";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          # Background Hang Reporter.
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "browser.search.serpEventTelemetry.enabled" = false;
          # Skip checking omni.ja and other files.
          "corroborator.enabled" = false;
          # Disabling Telemetry Coverage:
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          # Disabling Firefox Home (Activity Stream telemetry):
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          # Disabling WebVTT logging and test events.
          "media.webvtt.debug.logging" = false;
          "media.webvtt.testing.events" = false;
          # Disabling send content blocking log to about:protections.
          "browser.contentblocking.database.enabled" = false;
          # Disabling celebrating milestone toast when certain numbers of trackers are blocked.
          "browser.contentblocking.cfr-milestone.enabled" = false;

          # STUDIES
          # Disabling Studies.
          "app.shield.optoutstudies.enabled" = false;
          # Disabling Normandy/Shield:
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";

          # CRASH REPORTS
          # Disabling Crash Reports:
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          # Enforce no submission of backlogged Crash Reports.
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

          # OTHER REPORTS
          # Disabling Captive Portal detection:
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          # Disabling Network Connectivity checks.
          "network.connectivity-service.enabled" = false;
          # Disabling contentblocking reports:
          "browser.contentblocking.reportBreakage.url" = "";
          "browser.contentblocking.report.cookie.url" = "";
          "browser.contentblocking.report.cryptominer.url" = "";
          "browser.contentblocking.report.fingerprinter.url" = "";
          "browser.contentblocking.report.lockwise.enabled" = false;
          "browser.contentblocking.report.lockwise.how_it_works.url" = "";
          "browser.contentblocking.report.manage_devices.url" = "";
          "browser.contentblocking.report.monitor.enabled" = false;
          "browser.contentblocking.report.monitor.how_it_works.url" = "";
          "browser.contentblocking.report.monitor.sign_in_url" = "";
          "browser.contentblocking.report.monitor.url" = "";
          "browser.contentblocking.report.proxy.enabled" = false;
          "browser.contentblocking.report.proxy_extension.url" = "";
          "browser.contentblocking.report.social.url" = "";
          "browser.contentblocking.report.tracker.url" = "";
          "browser.contentblocking.report.endpoint_url" = "";
          "browser.contentblocking.report.monitor.home_page_url" = "";
          "browser.contentblocking.report.monitor.preferences_url" = "";
          "browser.contentblocking.report.vpn.enabled" = false;
          "browser.contentblocking.report.hide_vpn_banner" = true;
          "browser.contentblocking.report.show_mobile_app" = false;
          "browser.vpn_promo.enabled" = false;
          "browser.promo.focus.enabled" = false;
          # Blocking unwanted connections:
          "app.feedback.baseURL" = "";
          "app.support.baseURL" = "";
          "app.releaseNotesURL" = "";
          "app.update.url.details" = "";
          "app.update.url.manual" = "";
          "app.update.staging.enabled" = false;
          # Removing default handlers and translation engine:
          "gecko.handlerService.schemes.mailto.0.uriTemplate" = "";
          "gecko.handlerService.schemes.mailto.0.name" = "";
          "gecko.handlerService.schemes.mailto.1.uriTemplate" = "";
          "gecko.handlerService.schemes.mailto.1.name" = "";
          "gecko.handlerService.schemes.irc.0.uriTemplate" = "";
          "gecko.handlerService.schemes.irc.0.name" = "";
          "gecko.handlerService.schemes.ircs.0.uriTemplate" = "";
          "gecko.handlerService.schemes.ircs.0.name" = "";
          "browser.translation.engine" = "";
          # Disabling connections to Mozilla servers.
          "services.settings.server" = "";

          # SAFE BROWSING
          # Disabling SB (Safe Browsing):
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.passwords.enabled" = false;
          "browser.safebrowsing.allowOverride" = false;
          # Disabling SB checks for downloads (both local lookups + remote).
          "browser.safebrowsing.downloads.enabled" = false;
          # Disabling SB checks for downloads (remote):
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          # Disabling SB checks for unwanted software:
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          # Google connections:
          "browser.safebrowsing.downloads.remote.block_dangerous" = false;
          "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
          "browser.safebrowsing.provider.google.updateURL" = "";
          "browser.safebrowsing.provider.google.gethashURL" = "";
          "browser.safebrowsing.provider.google4.updateURL" = "";
          "browser.safebrowsing.provider.google4.gethashURL" = "";
          "browser.safebrowsing.provider.google.reportURL" = "";
          "browser.safebrowsing.reportPhishURL" = "";
          "browser.safebrowsing.provider.google4.reportURL" = "";
          "browser.safebrowsing.provider.google.reportMalwareMistakeURL" = "";
          "browser.safebrowsing.provider.google.reportPhishMistakeURL" = "";
          "browser.safebrowsing.provider.google4.reportMalwareMistakeURL" = "";
          "browser.safebrowsing.provider.google4.reportPhishMistakeURL" = "";
          "browser.safebrowsing.provider.google4.dataSharing.enabled" = false;
          "browser.safebrowsing.provider.google4.dataSharingURL" = "";
          "browser.safebrowsing.provider.google.advisory" = "";
          "browser.safebrowsing.provider.google.advisoryURL" = "";
          "browser.safebrowsing.provider.google4.advisoryURL" = "";
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.provider.mozilla.gethashURL" = "";
          "browser.safebrowsing.provider.mozilla.updateURL" = "";

          # BLOCK IMPLICIT OUTBOUND
          # Disabling link prefetching.
          "network.prefetch-next" = false;
          # Disabling DNS prefetching:
          "network.dns.DisablingPrefetch" = true;
          "network.dns.DisablingPrefetchFromHTTPS" = true;
          # Disabling predictor / prefetching:
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;
          # Disabling link-mouseover opening connection to linked server.
          "network.http.speculative-parallel-limit" = 0;
          # Disabling mousedown speculative connections on bookmarks and history.
          "browser.places.speculativeConnect.enabled" = false;

          # DNS / DoH / PROXY / SOCKS
          # Set the proxy server to do any DNS lookups when using SOCKS
          "network.proxy.socks_remote_dns" = true;
          # Disabling using UNC (Uniform Naming Convention paths).
          "network.file.Disabling_unc_paths" = true;
          # Disabling GIO as a potential proxy bypass vector.
          "network.gio.supported-protocols" = "";

          # ?
          # Disabling proxy direct failover for system requests [FF91+]
          # "network.proxy.failover_direct" = false;
          # Disabling proxy bypass for system request failures [FF95+]
          # "network.proxy.allow_bypass" = false;

          # Disabling DNS-over-HTTPS (DoH):
          "network.trr.mode" = 5;
          "network.trr.confirmationNS" = "";
          # Disabling skipping DoH when parental controls are enabled:
          "network.trr.uri" = "";
          "network.trr.custom_uri" = "";

          # LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
          # Disabling location bar making speculative connections.
          "browser.urlbar.speculativeConnect.enabled" = false;
          # Disabling location bar contextual suggestions:
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          # Disabling live search suggestions:
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.searches" = false;
          # Disabling urlbar trending search suggestions.
          "browser.urlbar.trending.featureGate" = false;
          # Disabling urlbar suggestions:
          "browser.urlbar.addons.featureGate" = false;
          "browser.urlbar.mdn.featureGate" = false;
          "browser.urlbar.pocket.featureGate" = false;
          "browser.urlbar.weather.featureGate" = false;
          "browser.urlbar.yelp.featureGate" = false;
          # Disabling urlbar clipboard suggestions.
          "browser.urlbar.clipboard.featureGate" = false;
          # Disabling recent searches.
          "browser.urlbar.recentsearches.featureGate" = false;
          # Disabling search and form history.
          "browser.formfill.enable" = false;
          # Disabling tab-to-search.
          "browser.urlbar.suggest.engines" = false;
          # Disabling coloring of visited links
          "layout.css.visited_links_enabled" = false;
          # Enabling separate default search engine in Private Windows and its UI setting:
          "browser.search.separatePrivateDefault" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          # Disabling merino.
          "browser.urlbar.merino.enabled" = false;

          # PASSWORDS
          # Disabling saving passwords and password alerts.
          "signon.rememberSignons" = false;
          "signon.generation.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "signon.management.page.breachAlertUrl" = "";
          # Set when Firefox should prompt for the primary password,
          # 0=once per session (default, 1=every time it's needed, 2=after n minutes).
          "security.ask_for_password" = 2;
          # Set how long in minutes Firefox should remember the primary password (0901).
          "security.password_lifetime" = 5;
          # Disabling auto-filling username & password form fields.
          "signon.autofillForms" = false;
          # Disabling formless login capture for Password Manager.
          "signon.formlessCapture.enabled" = false;
          # Limiting (or Disabling HTTP authentication credentials dialogs triggered by sub-resources),
          # 0 = don't allow sub-resources to open HTTP authentication credentials dialogs,
          # 1 = don't allow cross-origin sub-resources to open HTTP authentication credentials dialogs,
          # 2 = allow sub-resources to open HTTP authentication credentials dialogs (default):
          "network.auth.subresource-http-auth-allow" = 1;

          # DISK AVOIDANCE
          # Disabling disk cache
          "browser.cache.disk.enable" = false;
          # Disabling media cache from writing to disk in Private Browsing:
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          # Disabling storing extra session data,
          # 0=everywhere = 1=unencrypted sites = 2=nowhere.
          "browser.sessionstore.privacy_level" = 2;

          # HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
          # Require safe negotiation.
          "security.ssl.require_safe_negotiation" = true;
          # Disabling TLS1.3 0-RTT (round-trip time).
          "security.tls.enable_0rtt_data" = false;
          # Enforce OCSP fetching to confirm current validity of certificates,
          # 0=Disabled = 1=enabled (default = 2=enabled for EV certificates only).
          "security.OCSP.enabled" = 0;
          # Set OCSP fetch failures (non-stapled to hard-fail [SETUP-WEB]).
          "security.OCSP.require" = false;
          # Enabling strict PKP (Public Key Pinning),
          # 0=Disabled, 1=allow user MiTM (default; such as your antivirus, 2=strict).
          "security.cert_pinning.enforcement_level" = 2;

          # Disabling CRLite,
          # 0 = Disabled,
          # 1 = consult CRLite but only collect telemetry (default),
          # 2 = consult CRLite and enforce both "Revoked" and "Not Revoked" results,
          # 3 = consult CRLite and enforce "Not Revoked" results = but defer to OCSP for "Revoked" (default):
          "security.remote_settings.intermediates.enabled" = false;
          "security.remote_settings.intermediates.bucket" = "";
          "security.remote_settings.intermediates.collection" = "";
          "security.remote_settings.intermediates.signer" = "";
          "security.remote_settings.crlite_filters.enabled" = false;
          "security.remote_settings.crlite_filters.bucket" = "";
          "security.remote_settings.crlite_filters.collection" = "";
          "security.remote_settings.crlite_filters.signer" = "";
          "security.pki.crlite_mode" = 0;

          # MIXED CONTENT
          # Disabling insecure passive content (such as images on https pages [SETUP-WEB]
          # "security.mixed_content.block_display_content" = true; # Defense-in-depth
          # Enabling HTTPS-Only mode in all windows.
          "dom.security.https_only_mode" = true;
          # "dom.security.https_only_mode_pbm" = true;
          # Enabling HTTPS-Only mode for local resources
          # "dom.security.https_only_mode.upgrade_local" = true;
          # Disabling HTTP background requests.
          "dom.security.https_only_mode_send_http_background_request" = false;
          # Disabling ping to Mozilla for Man-in-the-Middle detection:
          "security.certerrors.mitm.priming.enabled" = false;
          "security.certerrors.mitm.priming.endpoint" = "";
          "security.pki.mitm_canary_issuer" = "";
          "security.pki.mitm_canary_issuer.enabled" = false;
          "security.pki.mitm_detected" = false;

          # UI
          # Display warning on the padlock for "broken security".
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          # Display advanced information on Insecure Connection warning pages.
          "browser.xul.error_pages.expert_bad_cert" = true;

          # REFERERS
          # Control the amount of cross-origin information to send,
          # 0=send full URI (default, 1=scheme+host+port+path, 2=scheme+host+port)
          "network.http.referer.XOriginTrimmingPolicy" = 2;

          # CONTAINERS
          # Enabling Container Tabs and its UI setting:
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          # Set behavior on "+ Tab" button to display container menu on left click [FF74+]
          # "privacy.userContext.newTabContainerOnLeftClick.enabled" = true;
          # Set external links to open in site-specific containers [FF123+]
          # "browser.link.force_default_user_context_id_for_external_opens" = true;

          # PLUGINS / MEDIA / WEBRTC
          # Force WebRTC inside the proxy.
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          # Force a single network interface for ICE candidates generation.
          "media.peerconnection.ice.default_address_only" = true;
          # Force exclusion of private IPs from ICE candidates [FF51+]
          # "media.peerconnection.ice.no_host" = true;
          # Disabling GMP (Gecko Media Plugins):
          "media.gmp-provider.enabled" = false;
          "media.gmp-manager.url" = "";
          "media.gmp-gmpopenh264.enabled" = false;

          # DOM
          # Prevent scripts from moving and resizing open windows.
          "dom.Disabling_window_move_resize" = true;

          # MISCELLANEOUS
          "browser.aboutConfig.showWarning" = false;
          # Removing temp files opened from non-PB windows with an external application.
          "browser.download.start_downloads_in_tmp_dir" = true;
          # Disabling sending additional analytics to web servers.
          "beacon.enabled" = false;
          # Removing temp files opened with an external application.
          "browser.helperApps.deleteTempFileOnExit" = true;
          # Disabling UITour backend so there is no chance that a remote page can use it:
          "browser.uitour.enabled" = false;
          "browser.uitour.url" = "";
          # Reset remote debugging to Disabled.
          "devtools.debugger.remote-enabled" = false;
          # Disabling websites overriding Firefox's keyboard shortcuts [FF58+]
          # 0 (default or 1=allow = 2=block
          # "permissions.default.shortcuts" = 2;
          # Removing special permissions for certain mozilla domains.
          "permissions.manager.defaultsUrl" = "";
          # Removing webchannel whitelist.
          "webchannel.allowObject.urlWhitelist" = "";
          # Use Punycode in Internationalized Domain Names to eliminate possible spoofing.
          "network.IDN_show_punycode" = true;
          # Enforce PDFJS = Disabling PDFJS scripting
          "pdfjs.Disabled" = false;
          "pdfjs.enableScripting" = false;
          # Disabling middle click on new tab button opening URLs or searches using clipboard.
          "browser.tabs.searchclipboardfor.middleclick" = false;
          # Disabling content analysis by DLP (Data Loss Prevention agents),
          # 0=Block all requests, 1=Warn on all requests (which lets the user decide, 2=Allow all requests:
          "browser.contentanalysis.enabled" = false;
          "browser.contentanalysis.default_result" = 0;
          # Disabling the default checkedness for "Save card and address to Firefox" checkboxes:
          "dom.payments.defaults.saveAddress" = false;
          "dom.payments.defaults.saveCreditCard" = false;
          # Disabling Displaying Javascript in History URLs.
          "browser.urlbar.filter.javascript" = true;

          # DOWNLOADS
          # Enabling user interaction for security by always asking where to download.
          "browser.download.useDownloadDir" = false;
          # Disabling downloads panel opening on every download.
          "browser.download.alwaysOpenPanel" = false;
          # Disabling adding downloads to the system's "recent documents" list.
          "browser.download.manager.addToRecentDocs" = false;
          # Enabling user interaction for security by always asking how to handle new mimetypes.
          "browser.download.always_ask_before_handling_new_types" = true;

          # EXTENSIONS
          # Limit allowed extension directories.
          "extensions.enabledScopes" = 5;
          # Disabling bypassing 3rd party extension install prompts.
          "extensions.postDownloadThirdPartyPrompt" = false;
          # Disabling webextension restrictions on certain mozilla domains [FF60+]
          # "extensions.webextensions.restrictedDomains" = "";
          # Disabling extensions suggestions.
          "extensions.webservice.discoverURL" = "";
          # For enabling extensions automatically when reproducing Firefox.
          "extensions.autoDisableScopes" = 0;
          # Disabling System Add-on updates:
          "extensions.systemAddon.update.enabled" = false;
          "extensions.systemAddon.update.url" = "";

          # ETP (ENHANCED TRACKING PROTECTION)
          # Enabling ETP Strict Mode.
          "browser.contentblocking.category" = "strict";
          # Disabling ETP web compat features [FF93+]
          # "privacy.antitracking.enableWebcompat" = false;

          # SHUTDOWN & SANITIZING
          # Enabling Firefox to clear items on shutdown.
          "privacy.sanitize.sanitizeOnShutdown" = true;
          # SANITIZE ON SHUTDOWN: IGNORES "ALLOW" SITE EXCEPTIONS | v2 migration is FF128+,
          # Set/enforce what items to clear on shutdown:
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown_v2.cache" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = true;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
          # "privacy.clearOnShutdown.siteSettings" = false; # [DEFAULT: false]
          # "privacy.clearOnShutdown_v2.siteSettings" = false; # [FF128+] [DEFAULT: false]
          # Set Session Restore to clear on shutdown [FF34+]
          # "privacy.clearOnShutdown.openWindows" = true;
          # SANITIZE ON SHUTDOWN: RESPECTS "ALLOW" SITE EXCEPTIONS FF103+ | v2 migration is FF128+,
          # Set "Cookies" and "Site Data" to clear on shutdown:
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.offlineApps" = true;
          "privacy.clearOnShutdown.sessions" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
          # SANITIZE SITE DATA: IGNORES "ALLOW" SITE EXCEPTIONS,
          # Set manual "Clear Data" items [FF128+]:
          "privacy.clearSiteData.cache" = true;
          "privacy.clearSiteData.cookiesAndStorage" = false; # keep false until it respects "allow" site exceptions
          "privacy.clearSiteData.historyFormDataAndDownloads" = true;
          # "privacy.clearSiteData.siteSettings" = false;
          # SANITIZE HISTORY: IGNORES "ALLOW" SITE EXCEPTIONS | clearHistory migration is FF128+,
          # Set manual "Clear History" items = also via Ctrl-Shift-Del:
          "privacy.cpd.cache" = true;
          "privacy.clearHistory.cache" = true;
          "privacy.cpd.formdata" = true;
          "privacy.cpd.history" = true;
          # "privacy.cpd.downloads" = true; # not used = see note above
          "privacy.clearHistory.historyFormDataAndDownloads" = true;
          "privacy.cpd.cookies" = false;
          "privacy.cpd.sessions" = true;
          "privacy.cpd.offlineApps" = true;
          "privacy.clearHistory.cookiesAndStorage" = false;
          # "privacy.cpd.openWindows" = false; # Session Restore
          # "privacy.cpd.passwords" = false;
          # "privacy.cpd.siteSettings" = false;
          # "privacy.clearHistory.siteSettings" = false;
          # SANITIZE MANUAL: TIMERANGE,
          # set "Time range to clear" for "Clear Data" and "Clear History",
          # 0=everything = 1=last hour = 2=last two hours = 3=last four hours = 4=today.
          "privacy.sanitize.timeSpan" = 0;

          # FPP (fingerprintingProtection)
          # Enabling FPP in PB mode [FF114+]
          # "privacy.fingerprintingProtection.pbmode" = true; # [DEFAULT: true FF118+]
          # Set global FPP overrides [FF114+]
          # "privacy.fingerprintingProtection.overrides" = "";
          # Set granular FPP overrides
          # "privacy.fingerprintingProtection.granularOverrides" = "";
          # Disabling remote FPP overrides [FF127+]
          # "privacy.fingerprintingProtection.remoteOverrides.enabled" = false;

          # OPTIONAL RFP (resistFingerprinting)
          # Enabling RFP
          "privacy.resistFingerprinting" = true;
          # "privacy.resistFingerprinting.pbmode" = true; # [FF114+]
          # Set RFP new window size max rounded values [FF55+]
          "privacy.window.maxInnerWidth" = 1400;
          "privacy.window.maxInnerHeight" = 900;
          # Disabling mozAddonManager Web API.
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          # Enabling letterboxing [FF67+]
          # "privacy.resistFingerprinting.letterboxing" = true; # [HIDDEN PREF]
          # "privacy.resistFingerprinting.letterboxing.dimensions" = ""; # [HIDDEN PREF]
          # Disabling RFP by domain [FF91+]
          # "privacy.resistFingerprinting.exemptedDomains" = "*.example.invalid";
          # Enabling RFP spoof english prompt,
          # 0=prompt, 1=Disabled, 2=enabled.
          "privacy.spoof_english" = 2;
          # Disabling using system colors.
          "browser.display.use_system_colors" = false;
          # Enforce links targeting new windows to open in a new tab instead,
          # 1=most recent window or tab, 2=new window, 3=new tab.
          "browser.link.open_newwindow" = 3;
          # Set all open window methods to abide by "browser.link.open_newwindow".
          "browser.link.open_newwindow.restriction" = 0;
          # Disabling WebGL (Web Graphics Library).
          "webgl.Disabled" = true;

          # OPTIONAL OPSEC
          # Start Firefox in PB (Private Browsing mode)
          # "browser.privatebrowsing.autostart" = true;
          # Disabling memory cache
          # capacity: -1=determine dynamically (default = 0=none = n=memory capacity in kibibytes
          # "browser.cache.memory.enable" = false;
          # "browser.cache.memory.capacity" = 0;
          # Disabling saving passwords
          # "signon.rememberSignons" = false;
          # Disabling permissions manager from writing to disk [FF41+] [RESTART]
          # "permissions.memory_only" = true; # [HIDDEN PREF]
          # Disabling intermediate certificate caching [FF41+] [RESTART]
          # "security.nocertdb" = true; #
          # Disabling favicons in history and bookmarks.
          "browser.chrome.site_icons" = false;
          # Exclude "Undo Closed Tabs" in Session Restore
          # "browser.sessionstore.max_tabs_undo" = 0;
          # Disabling resuming session from crash
          "browser.sessionstore.resume_from_crash" = false;
          # Disabling "open with" in download dialog [FF50+]
          # "browser.download.forbid_open_with" = true;
          # Disabling location bar suggestion types
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.weather" = false;
          # Disabling location bar dropdown.
          # "browser.urlbar.maxRichResults" = 0;
          # Disabling location bar autofill.
          "browser.urlbar.autoFill" = false;
          # Disabling browsing and download history.
          "places.history.enabled" = false;
          # Disabling Windows jumplist [WINDOWS]
          # "browser.taskbar.lists.enabled" = false;
          # "browser.taskbar.lists.frequent.enabled" = false;
          # "browser.taskbar.lists.recent.enabled" = false;
          # "browser.taskbar.lists.tasks.enabled" = false;
          # Discourage downloading to desktop
          # 0=desktop = 1=downloads (default = 2=custom
          # "browser.download.folderList" = 2;
          # Disabling Form Autofill:
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          # Limit events that can cause a pop-up
          # "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
          # Disabling page thumbnail collection
          # "browser.pagethumbnails.capturing_Disabled" = true; # [HIDDEN PREF]
          # Disabling Windows native notifications and use app notications instead [FF111+] [WINDOWS]
          # "alerts.useSystemBackend.windows.notificationserver.enabled" = false;
          # Force GPU sandboxing (Linux, default on Windows).
          "security.sandbox.gpu.level" = 1;
          # Enabling Site Isolation:
          "fission.autostart" = true;
          "gfx.webrender.all" = true;
          # Disabling Relay email feature.
          "signon.firefoxRelay.feature" = "Disabled";
          # Disabling Privacy-Preserving Attribution.
          "dom.private-attribution.submission.enabled" = false;

          # OPTIONAL HARDENING
          # Disabling MathML (Mathematical Markup Language).
          "mathml.Disabled" = true;
          # Disabling in-content SVG (Scalable Vector Graphics).
          # "svg.Disabled" = true;
          # Disabling graphite.
          "gfx.font_rendering.graphite.enabled" = false;
          # Disabling asm.js.
          "javascript.options.asmjs" = false;
          # Disabling Ion and baseline JIT to harden against JS exploits:
          "javascript.options.ion" = false;
          "javascript.options.baselinejit" = false;
          "javascript.options.jit_trustedprincipals" = true;
          # Disabling WebAssembly.
          "javascript.options.wasm" = false;
          # Disabling rendering of SVG OpenType fonts.
          "gfx.font_rendering.opentype_svg.enabled" = false;
          # Disabling widevine CDM (Content Decryption Module).
          "media.gmp-widevinecdm.enabled" = false;
          # Disabling all DRM content (EME: Encryption Media Extension):
          "media.eme.enabled" = false;
          "browser.eme.ui.enabled" = false;
          # Disabling IPv6 if using a VPN
          # "network.dns.DisablingIPv6" = true;
          # Control when to send a cross-origin referer
          # * 0=always (default = 1=only if base domains match = 2=only if hosts match
          # "network.http.referer.XOriginPolicy" = 2;
          # Set DoH bootstrap address [FF89+]
          # "network.trr.bootstrapAddr" = "10.0.0.1"; # [HIDDEN PREF]

          # DON'T TOUCH
          # Disabling Firefox blocklist:
          "extensions.blocklist.enabled" = false;
          "extensions.blocklist.addonItemURL" = "";
          "extensions.blocklist.detailsURL" = "";
          "extensions.blocklist.itemURL" = "";
          "services.blocklist.addons.collection" = "";
          "services.blocklist.addons.signer" = "";
          "services.blocklist.plugins.collection" = "";
          "services.blocklist.plugins.signer" = "";
          "services.blocklist.gfx.collection" = "";
          "services.blocklist.gfx.signer" = "";
          # Enforce no referer spoofing.
          "network.http.referer.spoofSource" = true;
          # Enforce a security delay on some confirmation dialogs such as install = open/save.
          "security.dialog_enable_delay" = 1000;
          # Enforce no First Party Isolation.
          "privacy.firstparty.isolate" = false;
          # Enforce SmartBlock shims (about:compat).
          "extensions.webcompat.enable_shims" = true;
          # Enforce no TLS 1.0/1.1 downgrades.
          "security.tls.version.enable-deprecated" = false;
          # Enforce disabling of Web Compatibility Reporter.
          "extensions.webcompat-reporter.enabled" = false;
          # Disabling Quarantined Domains.
          "extensions.quarantinedDomains.enabled" = false;
          # prefsCleaner: previously active items removed from arkenfox 115-127
          # "accessibility.force_Disabled" = "";
          # "browser.urlbar.dnsResolveSingleWordsAfterSearch" = "";
          # "network.protocol-handler.external.ms-windows-store" = "";
          # "privacy.partition.always_partition_third_party_non_cookie_storage" = "";
          # "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = "";
          # "privacy.partition.serviceWorkers" = "";

          # DON'T BOTHER
          # Disabling APIs.
          "geo.enabled" = false;
          # "full-screen-api.enabled" = false;
          # Set default permissions,
          # 0=always ask (default, 1=allow, 2=block):
          "permissions.default.geo" = 2;
          "permissions.default.camera" = 2;
          "permissions.default.microphone" = 2;
          "permissions.default.desktop-notification" = 2;
          # Virtual Reality.
          "permissions.default.xr" = 2;
          # Disabling canvas capture stream.
          "canvas.capturestream.enabled" = false;
          # Disabling offscreen canvas.
          "gfx.offscreencanvas.enabled" = false;
          # Disabling non-modern cipher suites
          # "security.ssl3.ecdhe_ecdsa_aes_128_sha" = false;
          # "security.ssl3.ecdhe_ecdsa_aes_256_sha" = false;
          # "security.ssl3.ecdhe_rsa_aes_128_sha" = false;
          # "security.ssl3.ecdhe_rsa_aes_256_sha" = false;
          # "security.ssl3.rsa_aes_128_gcm_sha256" = false; # no PFS
          # "security.ssl3.rsa_aes_256_gcm_sha384" = false; # no PFS
          # "security.ssl3.rsa_aes_128_sha" = false; # no PFS
          # "security.ssl3.rsa_aes_256_sha" = false; # no PFS
          # Control TLS versions
          # "security.tls.version.min" = 3; # [DEFAULT: 3]
          # "security.tls.version.max" = 4;
          # Disabling SSL session IDs [FF36+]
          # "security.ssl.Disabling_session_identifiers" = true;
          # Onions
          # "dom.securecontext.allowlist_onions" = true;
          # "network.http.referer.hideOnionSource" = true;
          # Referers
          # "network.http.sendRefererHeader" = 2;
          # "network.http.referer.trimmingPolicy" = 0;
          # Set the default Referrer Policy [FF59+]
          # 0=no-referer = 1=same-origin = 2=strict-origin-when-cross-origin = 3=no-referrer-when-downgrade
          # "network.http.referer.defaultPolicy" = 2; # [DEFAULT: 2]
          # "network.http.referer.defaultPolicy.pbmode" = 2; # [DEFAULT: 2]
          # Disabling HTTP Alternative Services [FF37+]
          # "network.http.altsvc.enabled" = false;
          # Disabling website control over browser right-click context menu
          # "dom.event.contextmenu.enabled" = false;
          # Disabling icon fonts (glyphs and local fallback rendering
          # "gfx.downloadable_fonts.enabled" = false; # [FF41+]
          # "gfx.downloadable_fonts.fallback_delay" = -1;
          # Disabling Clipboard API
          # "dom.event.clipboardevents.enabled" = false;
          # Enabling the DNT (Do Not Track HTTP header).
          "privacy.donottrackheader.enabled" = false;

          # Customize ETP settings:
          "privacy.query_stripping.strip_list" =
            "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";
          # "network.cookie.cookieBehavior" = 5; # [DEFAULT: 5]
          # "privacy.fingerprintingProtection" = true; # [FF114+] [ETP FF119+]
          # "privacy.partition.network_state.ocsp_cache" = true; # [DEFAULT: true FF123+]
          # "privacy.query_stripping.enabled" = true; # [FF101+]
          # "network.http.referer.disallowCrossSiteRelaxingDefault" = true;
          # "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true; # [FF100+]
          # "privacy.trackingprotection.enabled" = true;
          # "privacy.trackingprotection.socialtracking.enabled" = true;
          # "privacy.trackingprotection.cryptomining.enabled" = true; # [DEFAULT: true]
          # "privacy.trackingprotection.fingerprinting.enabled" = true; # [DEFAULT: true]
          # Allow embedded tweets and Reddit posts. Don't do it!
          # "urlclassifier.trackingSkipURLs" = "*.reddit.com = *.twitter.com = *.twimg.com"; # [HIDDEN PREF]
          # "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com = *.twitter.com = *.twimg.com"; # [HIDDEN PREF]
          # Disabling service workers
          # "dom.serviceWorkers.enabled" = false;
          # Disabling Web Notifications [FF22+]
          # "dom.webnotifications.enabled" = false;
          # Disabling Push Notifications:
          "dom.push.enabled" = false;
          "dom.push.connection.enabled" = false;
          "dom.push.serverURL" = "";
          "dom.push.userAgentID" = "";
          # Disabling WebRTC (Web Real-Time Communication).
          "media.peerconnection.enabled" = false;
          # Enabling GPC (Global Privacy Control in non-PB windows
          # "privacy.globalprivacycontrol.enabled" = true;

          # DON'T BOTHER: FINGERPRINTING
          # prefsCleaner: reset items useless for anti-fingerprinting
          # "browser.zoom.siteSpecific" = false;
          # "dom.enable_performance" = false;
          # "dom.enable_resource_timing" = false;
          # "dom.maxHardwareConcurrency" = 2;
          # "font.system.whitelist" = ""; # [HIDDEN PREF]
          # "general.appname.override" = ""; # [HIDDEN PREF]
          # "general.appversion.override" = ""; # [HIDDEN PREF]
          # "general.buildID.override" = "20181001000000"; # [HIDDEN PREF]
          # "general.oscpu.override" = ""; # [HIDDEN PREF]
          # "general.platform.override" = ""; # [HIDDEN PREF]
          # "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; rv:115.0 Gecko/20100101 Firefox/115.0"; # [HIDDEN PREF]
          # "media.ondevicechange.enabled" = false;
          # "media.video_stats.enabled" = false;
          # "webgl.enable-debug-renderer-info" = false;
          "ui.use_standins_for_native_colors" = true;
          "browser.display.use_document_fonts" = 0;
          "device.sensors.enabled" = false;
          "dom.gamepad.enabled" = false;
          "dom.netinfo.enabled" = false;
          "dom.vibrator.enabled" = false;
          "dom.w3c_touch_events.enabled" = 0;
          "dom.webaudio.enabled" = false;
          "media.navigator.enabled" = false;
          "media.webspeech.synth.enabled" = false;
          # Disabling API for measuring text width and height.
          "dom.textMetrics.actualBoundingBox.enabled" = false;
          "dom.textMetrics.baselines.enabled" = false;
          "dom.textMetrics.emHeight.enabled" = false;
          "dom.textMetrics.fontBoundingBox.enabled" = false;

          # WELCOME & WHAT'S NEW NOTICES
          "browser.startup.homepage_override.mstone" = "ignore";
          "startup.homepage_welcome_url" = "";
          "startup.homepage_welcome_url.additional" = "";
          "startup.homepage_override_url" = "";

          # WARNINGS
          "browser.tabs.warnOnClose" = false;
          "browser.tabs.warnOnCloseOtherTabs" = false;
          "browser.tabs.warnOnOpen" = false;
          "browser.warnOnQuitShortcut" = false;
          "full-screen-api.warning.delay" = 0;
          "full-screen-api.warning.timeout" = 0;
          "browser.warnOnQuit" = false;

          # UPDATES
          # Disabling auto-INSTALLING Firefox updates.
          "app.update.auto" = false;
          # Disabling auto-CHECKING for extension and theme updates.
          "extensions.update.enabled" = false;
          # Disabling auto-INSTALLING extension and theme updates.
          "extensions.update.autoUpdateDefault" = false;
          # Disabling extension metadata.
          "extensions.getAddons.cache.enabled" = false;
          # Disabling search engine updates (e.g. OpenSearch).
          "browser.search.update" = false;

          # CONTENT BEHAVIOR
          # Enabling "Find As You Type".
          "accessibility.typeaheadfind" = false;
          # Disabling autocopy default.
          "clipboard.autocopy" = false;
          # 0=none, 1-multi-line, 2=multi-line & single-line.
          "layout.spellcheckDefault" = 0;

          # FIREFOX HOME CONTENT
          # Recommended by Pocket.
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSearch" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;

          # UX FEATURES
          # Pocket Account.
          "extensions.pocket.enabled" = false;
          "extensions.screenshots.Disabled" = true;
          # Firefox Accounts & Sync.
          "identity.fxaccounts.enabled" = false;
          # Reader View.
          "reader.parse-on-load.enabled" = false;
          # Firefox-view.
          "browser.tabs.firefox-view" = false;

          # OTHER
          "browser.urlbar.showSearchTerms.enabled" = false;
          # "browser.bookmarks.max_backups" = 2;
          "security.tls.enable_kyber" = true;
          "network.http.http3.enable_kyber" = true;
          # Disabling CFR:
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false; # Disabling CFR [FF67+]
          # Minimum interval between session save operations.
          "browser.sessionstore.interval" = 30000;
          "network.manage-offline-status" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.DisablingResetPrompt" = true;
          # "xpinstall.signatures.required" = false; # enforced extension signing (Nightly/ESR

          # MORE
          # "security.insecure_connection_icon.enabled" = ""; # [DEFAULT: true FF70+]
          # "security.mixed_content.block_active_content" = ""; # [DEFAULT: true since at least FF60]
          "security.ssl.enable_ocsp_stapling" = false;
          # "webgl.Disabling-fail-if-major-performance-caveat" = ""; # [DEFAULT: true FF86+]
          "webgl.enable-webgl2" = false;
          # "webgl.min_capability_mode" = "";

          # DEPRECATED / RENAMED
          # Set RFP's font visibility level [FF94+]
          # "layout.css.font-visibility.resistFingerprinting" = 1; # [DEFAULT: 1]
          # Disabling service worker Web Notifications [FF44+]
          # "dom.webnotifications.serviceworker.enabled" = false;
          # Limit font visibility (Windows = Mac = some Linux [FF94+]
          # "layout.css.font-visibility.private" = 1;
          # "layout.css.font-visibility.standard" = 1;
          # "layout.css.font-visibility.trackingprotection" = 1;
          # Disabling permissions delegation [FF73+]
          # "permissions.delegation.enabled" = false;
          # Use en-US locale regardless of the system or region locale
          # "javascript.use_us_english_locale" = true; # [HIDDEN PREF]
          # Disabling skipping DoH when parental controls are enabled [FF70+]
          "network.dns.skipTRR-when-parental-control-enabled" = false;
          # Disabling PingCentre telemetry (used in several System Add-ons).
          "browser.ping-centre.telemetry" = false;
          # Disabling What's New toolbar icon.
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          # Disabling content analysis by DLP (Data Loss Prevention agents - replaced by default_result).
          "browser.contentanalysis.default_allow" = false;
          # Enforce non-native widget theme.
          "widget.non-native-theme.enabled" = true;
        };
        userChrome = builtins.readFile "${gnomeTheme}/userChrome.css";
        userContent = builtins.readFile "${gnomeTheme}/userContent.css";
      };
      normal = {
        id = 1;
        search.default = "google";
      };
    };
  };

  home.file.".mozilla/firefox/default/chrome/theme" = {
    source = "${gnomeTheme}/theme";
    recursive = true;
  };
}

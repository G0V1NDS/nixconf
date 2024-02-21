#
#  Firefox browser
#
{ inputs, lib, pkgs, vars,... }: let
  inherit (pkgs) runCommandNoCC writeText;
  inherit (pkgs.lib.strings) concatStrings;
  inherit (pkgs.lib.attrsets) mapAttrsToList;
in {

  home-manager.users.${vars.user} = {
  programs = {
    firefox = {
      enable = true;
      profiles."${vars.user}" = {
        id = 0;
        name = "${vars.user}";
        isDefault = true;
        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          vimium
          bitwarden
          floccus
          ublock-origin
        ];

        settings = {
          "app.shield.optoutstudies.enabled" = false;
          "app.update.auto" = false;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.contentblocking.category" = "strict";
          "browser.ctrlTab.recentlyUsedOrder" = false;
          "browser.discovery.enabled" = false;
          "browser.download.panel.shown" = true;
          "browser.laterrun.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.enabled" = false; # Make new tabs blank
          "browser.newtabpage.pinned" = false;
          "browser.protections_panel.infoMessage.seen" = true;
          "browser.quitShortcut.disabled" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.ssb.enabled" = true;
          "browser.startup.page" = 3; # Restore previous session
          "browser.toolbars.bookmarks.visibility" = "never";
          "datareporting.policy.dataSubmissionEnable" = false;
          "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
          "dom.forms.autocomplete.formautofill" = false; # Disable autofill
          "dom.payments.defaults.saveAddress" = false; # Disable address save
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
          "extensions.formautofill.creditCards.enabled" = false; # Disable credit cards
          "identity.fxaccounts.enabled" = false;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "signon.rememberSignons" = false;
        };
      };
    };
  };
  };
}

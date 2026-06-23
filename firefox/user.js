// Allow userChrome.css theme
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Read $XDG_DOWNLOAD_DIR
user_pref("browser.download.folderList", 1);

// Open new tabs right after the current one, not at the end
user_pref("browser.tabs.insertAfterCurrent", true);

// Remove telemetry
user_pref("browser.discovery.enabled", false);
user_pref("browser.shopping.experience2023.enabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("identity.fxaccounts.toolbar.enabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.telemetry.enabled", false);

// Allow userChrome.css theme
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Remove "This time, search with" magnifying glass from search bar
user_pref("browser.urlbar.scotchBonnet.enableOverride", false);

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

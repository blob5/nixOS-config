{ hostSettings, ... }:

{
  # Select internationalisation properties.
  i18n.defaultLocale = hostSettings.locale or "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = hostSettings.locale or "en_AU.UTF-8";
    LC_IDENTIFICATION = hostSettings.locale or "en_AU.UTF-8";
    LC_MEASUREMENT = hostSettings.locale or "en_AU.UTF-8";
    LC_MONETARY = hostSettings.locale or "en_AU.UTF-8";
    LC_NAME = hostSettings.locale or "en_AU.UTF-8";
    LC_NUMERIC = hostSettings.locale or "en_AU.UTF-8";
    LC_PAPER = hostSettings.locale or "en_AU.UTF-8";
    LC_TELEPHONE = hostSettings.locale or "en_AU.UTF-8";
  };
  time.timeZone = hostSettings.timezone or "Europe/Amsterdam";
}

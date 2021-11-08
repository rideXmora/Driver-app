class LanguageUtils {
  static String getLanguage(String topic) {
    if (topic == 'si_LK') {
      return "Sinhala";
    } else if (topic == 'ta_LK') {
      return "Tamil";
    } else if (topic == 'en_US') {
      return "English";
    }

    return "English";
  }

  static String getLocale(String topic) {
    if (topic == 'Sinhala') {
      return "si_LK";
    } else if (topic == 'Tamil') {
      return "ta_LK";
    } else if (topic == 'English') {
      return "en_US";
    }

    return "en_US";
  }
}

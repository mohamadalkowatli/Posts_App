import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHepler {
  Future<void> cacheLanguageCode(String languageCode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('Locale', languageCode);
  }

  Future<String> getCachedLanguageCode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? languageCode = sharedPreferences.getString('Locale');
    if (languageCode != null) {
      return languageCode;
    } else {
      return 'ar';
    }
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatternController extends GetxController {
  final SharedPreferences prefs;

  PatternController({required this.prefs});

  static const String _patternKey = "user_pattern";

  Future<void> savePattern(String pattern) async {
    await prefs.setString(_patternKey, pattern);
  }

  String? getPattern() {
    return prefs.getString(_patternKey);
  }

  bool validatePattern(String inputPattern) {
    final savedPattern = getPattern();
    return savedPattern == inputPattern;
  }
}

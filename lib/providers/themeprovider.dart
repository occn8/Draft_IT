import 'package:Draft_IT/index.dart';
import 'package:Draft_IT/themes/night.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;
  final _kThemePreference = "theme_preference";

  ThemeChanger() {
    _loadTheme();
  }

  void _loadTheme() {
    debugPrint("Entered loadTheme()");
    SharedPreferences.getInstance().then((prefs) {
      int preferredTheme = prefs.getInt(_kThemePreference) ?? 0;
      _themeData = themesData[Themes.values[preferredTheme]];
      notifyListeners();
    });
  }

  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = themesData[Themes.Light];
    }
    return _themeData;
  }

  setTheme(Themes theme) async {
    _themeData = themesData[theme];
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_kThemePreference, Themes.values.indexOf(theme));
  }
}

enum Themes { Light, Night, Dark }

final themesData = {
  Themes.Light: light,
  Themes.Night: night,
  Themes.Dark: dark
};

String enumName(Themes themeEnum) {
  return themeEnum.toString().split('.')[1];
}

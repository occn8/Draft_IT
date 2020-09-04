import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Draft_IT/index.dart';

class Launcher extends StatefulWidget {
  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  Future<bool> isFirstTime() async {
    SharedPreferences _prefs;

    var isFirstTime = _prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      _prefs.setBool('first_time', false);
      return false;
    } else {
      _prefs.setBool('first_time', false);
      return true;
    }
  }

  // @override
  // void initState() {
  //   super.initState();

  //   Timer(Duration(seconds: 3), () {
  //   isFirstTime().then((isFirstTime) {
  //     isFirstTime ? print("First time") : print("Not first time");
  //    });
  //   }
  //  );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: SharedPrefsHelper.getUsagetime(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.hasData
              ? Home()
              : OnboardingScreen();
        });
  }
}

class SharedPrefsHelper {
  static Future<bool> getUsagetime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('_isFirstUsage');
  }

  static Future<bool> setUsagetime(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool('_isFirstUsage', value);
  }
}

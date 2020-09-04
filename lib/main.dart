import 'index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var lkey = prefs.getString('loginkey');
  print(lkey);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeChanger(),
      child: Consumer<ThemeChanger>(
        builder: (context, ThemeChanger notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Draft-IT',
            theme: notifier.darkTheme ? darkl : light,
            home: lkey == null ? OnboardingScreen() : Home(),
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Draft-IT',
      theme: ThemeData(
        // textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.amber,
        // fontFamily: 'Gilroy',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Launcher(),
    );
  }
}

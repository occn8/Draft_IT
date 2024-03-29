import 'index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  await initNotifications(flutterLocalNotificationsPlugin);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var key = prefs.getString('usagekey');
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeChanger(),
      child: Consumer<ThemeChanger>(
        builder: (context, ThemeChanger notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Draft-IT',
            theme: notifier.themeData,
            home: key == null ? OnboardingScreen() : Home(),
          );
        },
      ),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Draft-IT',
//       theme: ThemeData(
//         // textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
//         primarySwatch: Colors.amber,
//         // fontFamily: 'Gilroy',
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: Home(),
//     );
//   }
// }

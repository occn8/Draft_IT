import 'index.dart';

void main() => runApp(MyApp());

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

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var lkey = prefs.getString('loginkey');
//   print(lkey);
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeChanger(),
//       child: Consumer<ThemeChanger>(
//         builder: (context, ThemeChanger notifier, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: notifier.darkTheme ? darkl : light,
//             // routes: {'/homepage':(context)=>HomePage()},
//             home: SplashScreen.navigate(
//               name: 'assets/pearl.flr',
//               next: (_) => lkey == null ? LogIn() : HomePage(),
//               isLoading: true,
//               startAnimation: 'intro',
//               backgroundColor: Color(0xff303030),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
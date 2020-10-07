import 'package:Draft_IT/index.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          CustomAppBar(
            title: 'Settings',
            leadOnTap: () {
              Navigator.pop(context);
            },
            leadIcon: Icons.arrow_back_ios,
            trailIcon: Icons.more_horiz,
          ),
        ]),
      ),
    );
  }
}

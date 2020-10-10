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
          SizedBox(height: 5),
          Card(
            child: ListTile(
              title: Text('Edit Tags'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text('Notifications'),
              value: true,
              onChanged: (bool value) {},
            ),
          ),
          Consumer<ThemeChanger>(
            builder: (context, notifier, child) => Card(
              child: ListTile(
                title: Text('Theme'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onTap: () => themer(context),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Security'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Support | Contacts'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              title: Text('About'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {
                buildShowAboutDialog(context);
              },
            ),
          ),
        ]),
      ),
    );
  }
}

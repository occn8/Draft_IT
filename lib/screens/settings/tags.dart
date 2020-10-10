import 'package:Draft_IT/index.dart';

class TagSettings extends StatefulWidget {
  TagSettings({Key key}) : super(key: key);

  @override
  _TagSettingsState createState() => _TagSettingsState();
}

class _TagSettingsState extends State<TagSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(
              title: 'Edit Tags',
              leadOnTap: () {
                Navigator.pop(context);
              },
              leadIcon: Icons.arrow_back_ios,
              trailIcon: Icons.more_horiz,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}

import 'package:Draft_IT/index.dart';

class Security extends StatefulWidget {
  Security({Key key}) : super(key: key);

  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(
              title: 'Security',
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

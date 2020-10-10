import 'package:Draft_IT/index.dart';

class Support extends StatefulWidget {
  Support({Key key}) : super(key: key);

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(
              title: 'Support & Contact',
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
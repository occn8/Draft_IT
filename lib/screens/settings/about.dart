import 'package:Draft_IT/index.dart';

void buildShowAboutDialog(BuildContext context) {
  return showAboutDialog(
    applicationIcon: AppIcon(),
    context: context,
    applicationName: 'Draft It',
    applicationVersion: ' 1.0',
    applicationLegalese: 'orchard.inc',
    children: [
      Text('Terms of Use'),
      Text('License'),
      Text('ChangeLogs'),
    ],
  );
}

class AppIcon extends StatelessWidget {
  const AppIcon({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.15,
      child: Image.asset('assets/icon.png'),
    );
  }
}

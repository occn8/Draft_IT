import 'package:Draft_IT/index.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<Draft> noteDraftList;

  @override
  Widget build(BuildContext context) {
    // if (noteDraftList == null) {
    //   noteDraftList = List<Draft>();
    //   updateListView();
    // }

    return SafeArea(
      child: DraftBuilder(),
    );
  }
}

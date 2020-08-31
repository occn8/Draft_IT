import 'package:Draft_IT/index.dart';

class MyHomePage extends StatelessWidget {
  
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

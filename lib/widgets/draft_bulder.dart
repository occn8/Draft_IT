import 'package:Draft_IT/index.dart';

class DraftBuilder extends StatefulWidget {
  final List<Draft> drafts;
  DraftBuilder({@required this.drafts});
  @override
  _DraftBuilderState createState() => _DraftBuilderState();
}

class _DraftBuilderState extends State<DraftBuilder> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<Draft> noteDraftList;
  int count = 0;

  List<Widget> draftList() {
    List<Widget> draftItemList = List();

    for (int i = 0; i < widget.drafts.length; i++) {
      draftItemList.add(draftItem(
        draft: widget.drafts[i],
        widget: getPriorityIcon(this.widget.drafts[i].priority),
        color: getPriorityColor(this.widget.drafts[i].priority),
        ontap1: () {},
        ontap2: () {},
      ));
    }
    return draftItemList;
  }

  Widget draftItem(
      {Draft draft,
      Widget widget,
      Color color,
      Function ontap1,
      Function ontap2}) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          child: widget,
          backgroundColor: color,
        ),
        title: Text(
          draft.title,
        ),
        subtitle: Text(draft.description ?? ''),
        trailing: GestureDetector(
            onTap: ontap1, child: Icon(Icons.delete, color: Colors.grey)),
        onTap: ontap2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: draftList(),
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }
  
}

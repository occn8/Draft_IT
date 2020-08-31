import 'package:Draft_IT/index.dart';

class DraftBuilder extends StatefulWidget {
  List<Draft> drafts;
  DraftBuilder({@required this.drafts});
  @override
  _DraftBuilderState createState() => _DraftBuilderState();
}

class _DraftBuilderState extends State<DraftBuilder> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  // List<Draft> noteDraftList;
  // int count = 0;

  List<Widget> draftList() {
    List<Widget> draftItemList = List();

    for (int i = 0; i < widget.drafts.length; i++) {
      draftItemList.add(draftItem(
        draft: widget.drafts[i],
        widget: getPriorityIcon(this.widget.drafts[i].priority),
        color: getPriorityColor(this.widget.drafts[i].priority),
        ontap1: () => _delete(context, widget.drafts[i]),
        ontap2: () => navigateToDetail(this.widget.drafts[i], 'Edit note'),
      ));
    }
    return draftItemList;
  }

  Widget draftItem({
    Draft draft,
    Widget widget,
    Color color,
    Function ontap1,
    Function ontap2,
  }) {
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
    if (widget.drafts == null) {
      widget.drafts = List<Draft>();
      updateListView();
    }
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

  void _delete(BuildContext context, Draft note) async {
    int result = await dataBaseHelper.deleteNote(note.id);
    if (result != 0) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Note deleted successfully')),
      );
      updateListView();
    }
  }

  void navigateToDetail(Draft note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDraft(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Draft>> noteListFuture = dataBaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.widget.drafts = noteList;
          // this.count = noteList.length;
        });
      });
    });
  }
}

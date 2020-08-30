import 'package:Draft_IT/index.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<Draft> noteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Draft>();
      updateListView();
    }

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Theme.of(context).accentColor,
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: Container(
                        margin: new EdgeInsets.all(5),
                        padding: new EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10)),
                        child:
                            new Icon(Icons.menu, size: 25, color: Colors.black),
                      ),
                    ),
                  ),
                  Text('what is your plan?'),
                ],
              ),
            ),
            Container(
              color: Colors.amber,
              height: 40,
            ),
            DraftBuilder(drafts: noteList)
          ],
        ),
        // body: Column(
        //   children: [

        //     Container(child: getDraftsList()),
        //   ],
        // ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToDetail(Draft('', '', 2), 'Add note');
          },
          label: Text('Add Task'),
          elevation: 4,
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  getDraftsList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                child: getPriorityIcon(this.noteList[position].priority),
                backgroundColor:
                    getPriorityColor(this.noteList[position].priority),
              ),
              title: Text(
                this.noteList[position].title,
              ),
              subtitle: Text(this.noteList[position].date),
              trailing: GestureDetector(
                  onTap: () => _delete(context, noteList[position]),
                  child: Icon(Icons.delete, color: Colors.grey)),
              onTap: () {
                navigateToDetail(this.noteList[position], 'Edit note');
              },
            ),
          );
        });
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
      _showSnackBar(context, 'Note deleted successfully');
      updateListView();
    }
  }

  Void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
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
    final Future<Database> DbFuture = dataBaseHelper.initializeDatabase();
    DbFuture.then((database) {
      Future<List<Draft>> noteListFuture = dataBaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

class DraftBuilder extends StatefulWidget {
  final List<Draft> drafts;
  DraftBuilder({@required this.drafts});
  @override
  _DraftBuilderState createState() => _DraftBuilderState();
}

class _DraftBuilderState extends State<DraftBuilder> {
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

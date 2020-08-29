import 'package:Draft_IT/index.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  List<Note> noteList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: getDraftsList(),
        // body: Column(
        //   children: [
        //     Container(
        //       height: 50,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Builder(
        //             builder: (context) => InkWell(
        //               splashColor: Theme.of(context).accentColor,
        //               onTap: () => Scaffold.of(context).openDrawer(),
        //               child: Container(
        //                 margin: new EdgeInsets.all(5),
        //                 padding: new EdgeInsets.all(8),
        //                 decoration: BoxDecoration(
        //                     color: Colors.white60,
        //                     borderRadius: BorderRadius.circular(10)),
        //                 child:
        //                     new Icon(Icons.menu, size: 25, color: Colors.black),
        //               ),
        //             ),
        //           ),
        //           Text('what is your plan?'),
        //         ],
        //       ),
        //     ),
        //     Container(child: getDraftsList()),
        //   ],
        // ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToDetail(Note('', '', 2), 'Add note');
          },
          label: Text('Add Task'),
          elevation: 4,
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  getDraftsList() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

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
                style: titleStyle,
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

  void _delete(BuildContext context, Note note) async {
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

  void navigateToDetail(Note note, String title) async {
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
      Future<List<Note>> noteListFuture = dataBaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

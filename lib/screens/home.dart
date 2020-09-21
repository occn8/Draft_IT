import 'package:Draft_IT/index.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _sfkey = GlobalKey<ScaffoldState>();
  List<Draft> drafts;

  DataBaseHelper dbhelper = DataBaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode _titleFocus, _descriptionFocus;

  @override
  void initState() {
    super.initState();
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  // List<Widget> draftList() {
  //   List<Widget> draftItemList = List();

  //   for (int i = 0; i < drafts.length; i++) {
  //     draftItemList.add(draftItem(
  //       draft: drafts[i],
  //       // widget: getPriorityIcon(this.drafts[i].priority),
  //       color: getPriorityColor(this.drafts[i].priority),
  //       // ontap1: () => _delete(context, drafts[i]),
  //       ontap2: () => Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (BuildContext ctx) => Details(draft: this.drafts[i]),
  //           )),
  //       key: Key(this.drafts[i].toString()),
  //       setstateRemove: () => this.drafts.removeAt(i),
  //       setstateUndo: () => this.drafts.insert(i, drafts[i]),
  //     ));
  //   }
  //   return draftItemList;
  // }

  // Widget draftItem({
  //   Draft draft,
  //   Widget widget,
  //   Color color,
  //   Function ontap1,
  //   Function ontap2,
  //   Key key,
  //   Function setstateRemove,
  //   Function setstateUndo,
  // }) {
  //   return Dismissible(
  //     direction: DismissDirection.endToStart,
  //     key: key,
  //     child: ItemTile(
  //       title: draft.title,
  //       subtitle: draft.description,
  //       date: draft.ddate,
  //       time: draft.dtime,
  //       color: color,
  //       ontap: ontap2,
  //     ),
  //     // onDismissed: (DismissDirection dir) {
  //     //   setState(setstateRemove);
  //     //   Scaffold.of(context).showSnackBar(
  //     //     SnackBar(
  //     //       content: Text(dir == DismissDirection.startToEnd
  //     //           ? '$item removed.'
  //     //           : '$item liked.'),
  //     //       action: SnackBarAction(
  //     //         label: 'UNDO',
  //     //         onPressed: () {
  //     //           setState(setstateUndo);
  //     //         },
  //     //       ),
  //     //     ),
  //     //   );
  //     // },
  //     background: Container(
  //       color: Colors.red,
  //       alignment: Alignment.centerLeft,
  //       child: Icon(Icons.delete_outline),
  //     ),
  //     secondaryBackground: Container(
  //       padding: EdgeInsets.all(5),
  //       color: Colors.green,
  //       alignment: Alignment.centerRight,
  //       child: Icon(Icons.archive),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: this._sfkey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Scrollbar(
          child: ListView(
            children: [
              customAppBar(),
              SearchBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PgStateSelector(
                    pgStates: ['Active', 'All', 'Done'],
                  ),
                ],
              ),
              FutureBuilder<List<Draft>>(
                  future: dbhelper.getDraftList(),
                  initialData: [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List<Widget> draftList() {
                      int count = snapshot.data.length;
                      List<Widget> draftItemList = List();

                      for (int i = 0; i < count; i++) {
                        draftItemList.add(
                          ItemTile(
                            title: snapshot.data[i].title,
                            subtitle: snapshot.data[i].description,
                            date: snapshot.data[i].ddate,
                            time: snapshot.data[i].dtime,
                            color: getPriorityColor(snapshot.data[i].priority),
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext ctx) =>
                                        Details(draft: snapshot.data[i]),
                                  )).then(
                                (value) {
                                  setState(() {});
                                },
                              );
                            },
                          ),
                        );
                      }
                      return draftItemList;
                    }

                    return Column(
                      children: draftList(),
                    );
                  }),
              // Column(children: draftList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                // title: const Text('Dialog title'),
                content: _buildBottomSheet(context),
                // actions: <Widget>[
                //   FlatButton(
                //     child: Text('Cancel'),
                //     onPressed: () => Navigator.pop(context, 'Cancel'),
                //   ),
                //   FlatButton(
                //     child: Text('OK'),
                //     onPressed: () => Navigator.pop(context, 'OK'),
                //   ),
                // ],
              ),
            ).then((returnVal) {
              setState(() {});
            });
            // this._sfkey
            // .currentState
            // .showBottomSheet((ctx) => _buildBottomSheet(ctx));
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return WriteDraft(Draft('', '', 2, 0, 0, 0, 0), 'Add draft');
            // })).then(
            //   (value) {
            //     setState(() {});
            //   },
            // );
          },
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 4,
          child: Icon(Icons.add, color: Colors.white),
        ),
        drawer: CustomDrawer(),
      ),
    );
  }

  Container customAppBar() {
    return Container(
      margin: new EdgeInsets.all(5),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => InkWell(
              splashColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                padding: new EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: new Icon(Icons.menu,
                    size: 25, color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          Text('what is your plan?'),
          Builder(
            builder: (context) => InkWell(
              splashColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Container(
                padding: new EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: new Icon(Icons.notifications,
                    size: 25, color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 0:
        return Colors.lime;
        break;
      case 1:
        return Colors.orangeAccent;
        break;
      case 2:
        return Color(0xfffa5b5d);
        break;
      default:
        return Colors.orangeAccent;
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

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      height: 210,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              focusNode: _titleFocus,
              controller: titleController,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(),
              onChanged: (value) {
                // updateTitle();
              },
              decoration: InputDecoration(
                labelText: 'Draft Title',
                hintText: 'Enter',
                prefixIcon: Icon(Icons.title),
                labelStyle: TextStyle(fontWeight: FontWeight.w800),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              focusNode: _descriptionFocus,
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(),
                prefixIcon: Icon(Icons.description),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Create',
                textScaleFactor: 1.5,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
              onPressed: () {
                create();
              }),
        ],
      ),
    );
  }

  Future<void> create() async {
    String title = titleController.text;
    String description = descriptionController.text;

    Draft draft = Draft(title, description,
        DateFormat.yMMMd().format(DateTime.now()), 1, 0, 0, 0, 0);

    await dbhelper.insertDraft(draft);

    Navigator.pop(context);
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return WriteDraft(draft, 'Add draft');
    // })).then(
    //   (value) {
    //     setState(() {});
    //   },
    // );
    titleController.clear();
    descriptionController.clear();
  }
  // void navigateToDetail(Draft note, String title) async {
  //   bool result =
  //       await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return AddDraft(note, title);
  //   }));
  //   if (result == true) {
  //     updateListView();
  //   }
  // }

  // void updateListView() {
  //   final Future<Database> dbFuture = dataBaseHelper.initializeDatabase();
  //   dbFuture.then((database) {
  //     Future<List<Draft>> noteListFuture = dataBaseHelper.getDraftList();
  //     noteListFuture.then((noteList) {
  //       setState(() {
  //         this.drafts = noteList;
  //         // this.count = noteList.length;
  //       });
  //     });
  //   });
  // }
}

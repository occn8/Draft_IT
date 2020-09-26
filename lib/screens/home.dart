import 'package:Draft_IT/index.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _sfkey = GlobalKey<ScaffoldState>();
  List<Draft> drafts;
  final List<String> pgStates = ['Active', 'All', 'Overdue'];
  DataBaseHelper dbhelper = DataBaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode _titleFocus, _descriptionFocus;
  int pgSelect = 1;

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

  int currentIndex = 1;
  bool isSelected;

  List<Widget> pgSelector() {
    List<Widget> pgStateItemList = List();

    for (int i = 0; i < pgStates.length; i++) {
      isSelected = currentIndex == i;

      pgStateItemList.add(pgStateItem(
        state: pgStates[i],
        isSelected: isSelected,
        ontap: () {
          setState(() {
            currentIndex = i;
          });
        },
      ));
    }
    return pgStateItemList;
  }

  Widget pgStateItem({String state, bool isSelected, Function ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // width: 90,
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 0),
              shape: BoxShape.rectangle),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                ),
                child: Text(
                  state,
                  style: isSelected
                      ? TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor)
                      : TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorDark),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                height: 8.0,
                width: isSelected ? 24.0 : 16.0,
                decoration: BoxDecoration(
                  color:
                      isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     PgStateSelector(
              //       pgStates: ['Active', 'All', 'Overdue'],
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: pgSelector(),
              ),
              FutureBuilder<List<Draft>>(
                  future: currentIndex == 1
                      ? dbhelper.getDraftList()
                      : currentIndex == 2
                          ? dbhelper.getFilteredDraftList('isDone')
                          : dbhelper.getFilteredDraftList('isStarred'),
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

                    return snapshot.data.length == 0
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 40),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text('No Drafts yet!'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 40),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    Image.asset('assets/images/annotation.png'),
                              ),
                            ],
                          )
                        : Column(
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
                backgroundColor: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: _createDialog(context),
              ),
            ).then((returnVal) {
              setState(() {});
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 4,
          child: Icon(Icons.add, color: Theme.of(context).primaryColorLight),
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

  Container _createDialog(BuildContext context) {
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
}

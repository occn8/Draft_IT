import 'package:Draft_IT/index.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  DataBaseHelper dbhelper = DataBaseHelper();
  TextEditingController tagController = TextEditingController();
  FocusNode _tagFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // width: 20,
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text('occn lary'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Consumer<ThemeChanger>(
                      builder: (context, notifier, child) => InkWell(
                          onTap: () {
                            notifier.toggleTheme();
                          },
                          child: Icon(
                            Icons.brightness_4,
                            size: 28,
                            color: Theme.of(context).primaryColorDark,
                          )),
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.calendar_today,
                      size: 28,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    SizedBox(width: 15),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => Settings()));
                        },
                        child: Icon(
                          Icons.settings,
                          size: 28,
                          color: Theme.of(context).primaryColorDark,
                        )),
                    SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.featured_play_list,
                color: Theme.of(context).primaryColor),
            title: Text(
              'My Drafts',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Starred'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => FilteredTemplate(
                            strFilter: 'isStarred',
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('Reminders'),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Shared'),
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Archived'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => FilteredTemplate(
                            strFilter: 'isArchived',
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Finance'),
          ),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Trash'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => FilteredTemplate(
                            strFilter: 'isTrash',
                          )));
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              'TAGS',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w800),
            ),
          ),
          tagList(),
          ListTile(
            leading: Icon(
              Icons.add_circle,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Add a Tag',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: _tagDialog(context),
                ),
              ).then((returnVal) {
                setState(() {});
              });
            },
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  FutureBuilder<List> tagList() {
    return FutureBuilder(
      future: dbhelper.getTagList(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Widget> tgList() {
          List<Widget> tgItemList = List();

          for (int i = 0; i < snapshot.data.length; i++) {
            tgItemList.add(ListTile(
              leading: Icon(Icons.loyalty),
              title: Text(snapshot.data[i].name),
            ));
          }
          return tgItemList;
        }

        // return Column(children: tgList());
        return Container(
          height: snapshot.data.length <= 1
              ? 50
              : snapshot.data.length == 2 ? 100 : 145,
          child: snapshot.data.length > 0
              ? Scrollbar(
                  child: ListView.builder(
                    itemExtent: 50,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(
                          Icons.loyalty,
                          color: snapshot.data[index].name == 'Work' ||
                                  snapshot.data[index].name == 'Work '
                              ? Colors.amber
                              : snapshot.data[index].name == 'Personal'
                                  ? Colors.blueAccent
                                  : Theme.of(context).primaryColorDark,
                        ),
                        title: Text(snapshot.data[index].name),
                      );
                    },
                  ),
                )
              : Center(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('No Tags Added yet!')),
                ),
        );
      },
    );
  }

  Container _tagDialog(BuildContext context) {
    return Container(
      height: 160,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextField(
              focusNode: _tagFocus,
              controller: tagController,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(),
              maxLength: 10,
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Tag Name',
                hintText: 'Enter Tag Name',
                prefixIcon: Icon(Icons.title),
                labelStyle: TextStyle(fontWeight: FontWeight.w800),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add Tag',
                textScaleFactor: 1.5,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),
              onPressed: () async {
                Tag tag = Tag(tagController.text);
                await dbhelper.insertTag(tag);
                Navigator.pop(context);
                tagController.clear();
              }),
        ],
      ),
    );
  }
}

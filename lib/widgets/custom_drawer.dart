import 'package:Draft_IT/index.dart';
import 'package:Draft_IT/widgets/add_tag.dart';

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
            padding: EdgeInsets.all(5),
            child: Text(
              'TAGS',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.fiber_manual_record,
              color: Colors.blue,
            ),
            title: Text('Work'),
          ),
          ListTile(
            leading: Icon(
              Icons.fiber_manual_record,
              color: Colors.amber,
            ),
            title: Text('Personal'),
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Add a Tag'),
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
        ],
      ),
    );
  }

  FutureBuilder<List> tagList() {
    return FutureBuilder(
      future: dbhelper.getTagList(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(snapshot.data[index].name),
            );
          },
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

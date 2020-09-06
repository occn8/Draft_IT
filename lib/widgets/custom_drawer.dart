import 'package:Draft_IT/index.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  }) : super(key: key);

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
                        child: Icon(Icons.person),
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
                          child: Icon(Icons.brightness_4, size: 28)),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.calendar_today, size: 28),
                    SizedBox(width: 15),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => Settings()));
                        },
                        child: Icon(Icons.settings, size: 28)),
                    SizedBox(width: 5),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.featured_play_list),
            title: Text('My Drafts'),
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Starred'),
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
          ),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Trash'),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text('TAGS'),
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
          ),
        ],
      ),
    );
  }
}

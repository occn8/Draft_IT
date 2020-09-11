import 'package:Draft_IT/index.dart';

class Details extends StatefulWidget {
  final Draft draft;

  const Details({this.draft});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DataBaseHelper helper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: 50),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 5),
                      child: Text(
                        widget.draft.ddate ?? 'No Due date',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: Text(
                    widget.draft.title ?? 'No Title Added',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    widget.draft.description ?? 'No Description Added',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Row(
                //   children: <Widget>[]..addAll(organizersSection(widget.draft)),
                // ),
              ],
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        // margin: new EdgeInsets.all(5),
                        padding: new EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: new Icon(Icons.arrow_back_ios,
                            size: 25,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ),
                  Text(''),
                  Row(
                    children: [
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          child: Container(
                            padding: new EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.star_border,
                                size: 25,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          child: Container(
                            padding: new EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.share,
                                size: 25,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {},
                          child: Container(
                            padding: new EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.folder_open,
                                size: 25,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Builder(
                        builder: (context) => InkWell(
                          splashColor: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            deleteDialog(context).then((returnVal) async {
                              if (returnVal == 'OK') {
                                Navigator.pop(context);
                                await helper.deleteDraft(widget.draft.id);
                              }
                            });
                          },
                          child: Container(
                            padding: new EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.delete_outline,
                                size: 25,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WriteDraft(this.widget.draft, 'Edit Draft');
            })).then(
              (value) {
                setState(() {});
              },
            );
          },
          elevation: 4,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.edit, color: Theme.of(context).primaryColorLight),
        ),
      ),
    );
  }

  Future<String> deleteDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(
            child: Text(
          'Delete',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).primaryColor),
        )),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          'Continue with Trashing?',
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context, 'OK'),
          ),
        ],
      ),
    );
  }
}

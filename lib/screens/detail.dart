import 'package:Draft_IT/index.dart';

class Details extends StatefulWidget {
  final Draft draft;

  const Details({this.draft});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
                          onTap: () {},
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

  // List<Widget> organizersSection(Draft todo) {
  //   return todo.todos.map((td) => OrgSection(td.title, td.isDone)).toList();
  // }
}

class OrgSection extends StatelessWidget {
  final String orgName;
  final int orgImg;
  OrgSection(
    this.orgName,
    this.orgImg,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(),
              child: Text(orgImg.toString()),
            ),
          ),
          SizedBox(width: 10),
          Text(orgName,
              style: TextStyle(
                fontSize: 13,
              )),
        ],
      ),
    );
  }
}

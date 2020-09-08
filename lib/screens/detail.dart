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
                Container(
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: Text(
                    widget.draft.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    widget.draft.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: new Icon(Icons.arrow_back_ios,
                            size: 25, color: Colors.black),
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
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.star_border,
                                size: 25, color: Colors.black),
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
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.share,
                                size: 25, color: Colors.black),
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
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.folder_open,
                                size: 25, color: Colors.black),
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
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: new Icon(Icons.delete_outline,
                                size: 25, color: Colors.black),
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
              return AddDraft(Draft('', '', '', '', 2, 0, 0, 0, 0), 'Edit draft');
            }));
          },
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}

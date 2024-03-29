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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          child: RichText(
                            text: widget.draft.ddate != null &&
                                    widget.draft.dtime != null
                                ? TextSpan(
                                    children: [
                                        TextSpan(text: 'Due: '),
                                        TextSpan(
                                            text: widget.draft.ddate.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColorDark)),
                                        TextSpan(text: ' at '),
                                        TextSpan(
                                            text: widget.draft.dtime.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColorDark)),
                                      ],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor))
                                : widget.draft.ddate != null
                                    ? TextSpan(
                                        children: [
                                            TextSpan(
                                                text: 'Due: ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            TextSpan(
                                                text: widget.draft.ddate
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColorDark)),
                                          ],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .primaryColorDark))
                                    : TextSpan(
                                        children: [
                                            TextSpan(
                                              text: 'No Due date',
                                            ),
                                          ],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .primaryColor)),
                          )
                          // Text(
                          //   widget.draft.ddate == null
                          //       ? 'No Due date'
                          //       : widget.draft.ddate.toString() +
                          //           ' at ' +
                          //           widget.draft.dtime.toString(),
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          ),
                      Row(
                        children: [
                          Text(
                            'Done',
                            style: TextStyle(fontSize: 12),
                          ),
                          Checkbox(
                            activeColor: Theme.of(context).primaryColor,
                            checkColor: Theme.of(context).primaryColorLight,
                            onChanged: (bool value) async {
                              if (widget.draft.isDone == 0) {
                                widget.draft.isDone = 1;
                                await helper.toggleIsDone(
                                    widget.draft.id, widget.draft.isDone);
                                print(widget.draft.isDone);
                              } else {
                                widget.draft.isDone = 0;
                                await helper.toggleIsDone(
                                    widget.draft.id, widget.draft.isDone);
                                print(widget.draft.isDone);
                              }
                              setState(() {});
                            },
                            // value: widget.draft.isDone == 0 ? false : true,
                            value: getIsDone(widget.draft.isDone),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TagCircle(color: getPriorityColor(widget.draft.priority)),
                      SizedBox(width: 10),
                      Text(
                        widget.draft.title ?? 'No Title Added',
                        style: TextStyle(
                          decoration: widget.draft.isDone == 1
                              ? TextDecoration.lineThrough
                              : null,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: widget.draft.title == null
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(height: 5),
                Container(
                  // color: Theme.of(context).cardColor,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '     ' + widget.draft.description ??
                        'No Description Added',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: widget.draft.description == null
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.draft.notes ?? 'No Notes Added',
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.draft.notes == null
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Row(
                //   children: <Widget>[]..addAll(organizersSection(widget.draft)),
                // ),
              ],
            ),
            customAppBar(),
          ],
        ),
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
    );
  }

  customAppBar() {
    return Container(
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
                  // color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new Icon(Icons.arrow_back_ios,
                    size: 25, color: Theme.of(context).primaryColorDark),
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
                  onTap: () async {
                    if (widget.draft.isStarred == 0) {
                      widget.draft.isStarred = 1;
                      await helper.toggleIsStarred(
                          widget.draft.id, widget.draft.isStarred);
                    } else {
                      widget.draft.isStarred = 0;
                      await helper.toggleIsStarred(
                          widget.draft.id, widget.draft.isStarred);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: new EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Icon(
                      widget.draft.isStarred == 0
                          ? Icons.star_border
                          : Icons.star_border,
                      size: 25,
                      color: widget.draft.isStarred == 0
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              // Builder(
              //   builder: (context) => InkWell(
              //     splashColor: Theme.of(context).accentColor,
              //     borderRadius: BorderRadius.circular(10),
              //     onTap: () {},
              //     child: Container(
              //       padding: new EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //         // color: Theme.of(context).cardColor,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       child: new Icon(Icons.share,
              //           size: 25, color: Theme.of(context).primaryColorDark),
              //     ),
              //   ),
              // ),
              // SizedBox(width: 5),
              Builder(
                builder: (context) => InkWell(
                  splashColor: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    if (widget.draft.isArchived == 0) {
                      widget.draft.isArchived = 1;
                      await helper.toggleIsArchived(
                          widget.draft.id, widget.draft.isArchived);
                    } else {
                      widget.draft.isArchived = 0;
                      await helper.toggleIsArchived(
                          widget.draft.id, widget.draft.isArchived);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: new EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Icon(
                      widget.draft.isArchived == 0
                          ? Icons.folder_open
                          : Icons.folder_open,
                      size: 25,
                      color: widget.draft.isArchived == 0
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColor,
                    ),
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
                      if (returnVal == 'Delete') {
                        Navigator.pop(context);
                        await helper.deleteDraft(widget.draft.id);
                      }
                      if (returnVal == 'Trash') {
                        // Navigator.pop(context);
                        if (widget.draft.isTrash == 0) {
                          widget.draft.isTrash = 1;
                          await helper.toggleIsTrash(
                              widget.draft.id, widget.draft.isTrash);
                        } else {
                          widget.draft.isTrash = 0;
                          await helper.toggleIsTrash(
                              widget.draft.id, widget.draft.isTrash);
                        }
                        setState(() {});
                      }
                    });
                  },
                  child: Container(
                    padding: new EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Icon(Icons.delete_outline,
                        size: 25,
                        color: widget.draft.isTrash == 0
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor),
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
        ],
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
          widget.draft.isTrash != 1
              ? 'Continue to Trash or Delete?'
              : 'Continue to Restore or Delete?',
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              widget.draft.isTrash != 1 ? 'Trash' : 'Restore',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () => Navigator.pop(context, 'Trash'),
          ),
          FlatButton(
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () => Navigator.pop(context, 'Delete'),
          ),
        ],
      ),
    );
  }

  bool getIsDone(int isdone) {
    switch (isdone) {
      case 0:
        return false;
        break;
      case 1:
        return true;
        break;
      default:
        return false;
    }
  }
}

import 'package:Draft_IT/index.dart';

class FilteredTemplate extends StatefulWidget {
  final String strFilter;
  const FilteredTemplate({this.strFilter});

  @override
  _FilteredTemplateState createState() => _FilteredTemplateState();
}

class _FilteredTemplateState extends State<FilteredTemplate> {
  List<Draft> drafts;
  DataBaseHelper dbhelper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(
              title: widget.strFilter == 'isStarred'
                  ? 'Starred'
                  : widget.strFilter == 'isArchived'
                      ? 'Archive'
                      : widget.strFilter == 'isTrash'
                          ? 'Trash'
                          : widget.strFilter == 'isDone'
                              ? 'Completed Drafts'
                              : widget.strFilter,
              leadOnTap: () {
                Navigator.pop(context);
              },
              leadIcon: Icons.arrow_back_ios,
              trailIcon: Icons.more_horiz,
            ),
            SizedBox(height: 5),
            FutureBuilder<List<Draft>>(
                future: dbhelper.getFilteredDraftList(widget.strFilter),
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
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                widget.strFilter == 'isStarred'
                                    ? 'Oh! Nothing Starred yet'
                                    : widget.strFilter == 'isArchived'
                                        ? 'Oh! Nothing Archived yet'
                                        : widget.strFilter == 'isTrash'
                                            ? 'Yeaah! Nothing Trashed yet'
                                            : widget.strFilter == 'isDone'
                                                ? 'Oops! No Draft Completed yet'
                                                : 'Oops Nothing here yet!',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              )),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: widget.strFilter == 'isTrash'
                                  ? Image.asset('assets/images/Throw_away.png')
                                  : widget.strFilter == 'isDone'
                                      ? Image.asset(
                                          'assets/images/completing.png')
                                      : Image.asset('assets/images/void.png'),
                            ),
                          ],
                        )
                      : Column(children: draftList());
                }),
          ],
        ),
      ),
    );
  }
}

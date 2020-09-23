import 'package:Draft_IT/index.dart';

class FutureDraftBuilder extends StatefulWidget {
  final Future<List<Draft>> future;
  final String strFilter;

  const FutureDraftBuilder({@required this.future, this.strFilter});
  @override
  _FutureDraftBuilderState createState() => _FutureDraftBuilderState(future);
}

class _FutureDraftBuilderState extends State<FutureDraftBuilder> {
  final Future<List<Draft>> future;

  _FutureDraftBuilderState(this.future);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Draft>>(
        future: future,
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
                      margin: EdgeInsets.only(left: 15, right: 15, top: 40),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        widget.strFilter == 'isStarred'
                            ? 'Oops Nothing Starred yet!'
                            : widget.strFilter == 'isArchived'
                                ? 'Oops Nothing Archived yet!'
                                : widget.strFilter == 'isTrash'
                                    ? 'Oops Nothing Trashed yet!'
                                    : 'Oops Nothing here yet!',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 40),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('assets/images/annotation.png'),
                    ),
                  ],
                )
              : Column(
                  children: draftList(),
                );
        });
  }
}

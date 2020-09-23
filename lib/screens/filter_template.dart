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
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            FutureBuilder<List<Draft>>(
                future: dbhelper.getFilteredDraftList('isDone'),
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

                  return Column(
                    children: draftList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

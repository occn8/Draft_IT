import 'package:Draft_IT/index.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

class SearchView extends StatefulWidget {
  // SearchView({Key key}) : super(key: key);
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  DataBaseHelper dbhelper = DataBaseHelper();

  // Future<List<Draft>> search(String search) async {
  //   await Future.delayed(Duration(milliseconds: 200));
  //   return List.generate(search.length, (int index) {
  //     return Draft(
  //       "Title : $search $index",
  //       "Description :$search $index",
  //     );
  //   });
  // }

  Future<List<Draft>> _getSearchDrafts(String text) async {
    List<Draft> searcheddrafts = [];
    var drafts = await dbhelper.getDraftList();
    searcheddrafts.addAll(drafts.where(
        (element) => element.title.toLowerCase().contains(text.toLowerCase())));
    return searcheddrafts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar<Draft>(
              onSearch: _getSearchDrafts,
              onItemFound: (Draft draft, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext ctx) => Details(draft: draft),
                        )).then(
                      (value) {
                        setState(() {});
                      },
                    );
                  },
                  title: Text(draft.title),
                  subtitle: Text(draft.description),
                );
              },
              // loader: Center(
              //     child: Theme(
              //   data: Theme.of(context).copyWith(accentColor: Colors.red),
              //   child: CircularProgressIndicator(
              //       // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //       ),
              // )),

              textStyle: TextStyle(color: Theme.of(context).primaryColorDark),
              loader: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff308c98)),
              )),
              minimumChars: 1,
              placeHolder: ListView(
                children: [
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Search through your drafts',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Image.asset('assets/images/searching.png'),
                ],
              ),
              emptyWidget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView(
                    children: [
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'No results Found!',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(child: Image.asset('assets/images/not_found.png'))
                    ],
                  )),
              cancellationWidget: Text('Back'),
              onCancelled: () {
                Navigator.pop(context);
                // print("Cancelled triggered");
              },
              searchBarStyle: SearchBarStyle(
                backgroundColor: Theme.of(context).cardColor,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

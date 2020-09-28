// import 'dart:math';

import 'package:Draft_IT/index.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchBarController<Draft> _searchBarController = SearchBarController();
  bool isReplay = false;
   DataBaseHelper dbhelper = DataBaseHelper();

  Future<List<Draft>> _getALlPosts(String text) async {
    // await dbhelper.getDraftList();
    // // if (isReplay) return [Draft("Replaying !", "Replaying body")];
    // // if (text.length == 5) throw Error();
    // // if (text.length == 6) return [];
    // List<Draft> posts = [];

    // for (int i = 0; i < 10; i++) {
    //   posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    // }
    return await dbhelper.getDraftList();
  }

  @override
  Widget build(BuildContext context) {
    return  SearchBar<Draft>(
        searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
        headerPadding: EdgeInsets.symmetric(horizontal: 10),
        listPadding: EdgeInsets.symmetric(horizontal: 10),
        onSearch: _getALlPosts,
        searchBarController: _searchBarController,
        placeHolder: Text("placeholder"),
        cancellationWidget: Text("Cancel"),
        emptyWidget: Text("empty"),
        indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
        header: Row(
          children: <Widget>[
            RaisedButton(
              child: Text("sort"),
              onPressed: () {
                _searchBarController.sortList((Draft a, Draft b) {
                  return a.title.compareTo(b.title);
                });
              },
            ),
            RaisedButton(
              child: Text("Desort"),
              onPressed: () {
                _searchBarController.removeSort();
              },
            ),
            RaisedButton(
              child: Text("Replay"),
              onPressed: () {
                isReplay = !isReplay;
                _searchBarController.replayLastSearch();
              },
            ),
          ],
        ),
        onCancelled: () {
          print("Cancelled triggered");
        },
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        onItemFound: (Draft post, int index) {
          return Container(
            color: Colors.lightBlue,
            child: ListTile(
              title: Text(post.title),
              isThreeLine: true,
              subtitle: Text(post.description),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
              },
            ),
          );
        },
      );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
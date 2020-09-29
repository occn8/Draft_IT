import 'package:Draft_IT/index.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

// class Post {
//   final String title;
//   final String description;

//   Post(this.title, this.description);
// }

class SearchView extends StatefulWidget {
  // SearchView({Key key}) : super(key: key);
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  DataBaseHelper dbhelper = DataBaseHelper();

  // Future<List<Draft>> search(String search) async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   return List.generate(search.length, (int index) {
  //     return Draft(
  //       "Title : $search $index",
  //       "Description :$search $index",
  //     );
  //   });
  // }

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
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar<Draft>(
              onSearch: _getALlPosts,
              onItemFound: (Draft post, int index) {
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.description),
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
              placeHolder: Image.asset('assets/images/search.png'),
              cancellationWidget: Text('Ok'),
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

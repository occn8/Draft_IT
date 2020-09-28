import 'package:Draft_IT/index.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar<Post>(
              onSearch: search,
              onItemFound: (Post post, int index) {
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
              loader: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff308c98)),
              )),
              minimumChars: 1,
              searchBarStyle: SearchBarStyle(
                backgroundColor: Theme.of(context).cardColor,
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

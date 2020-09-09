import 'package:Draft_IT/index.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key key,
  }) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  List<Draft> drafts;
  _MySearchDelegate _delegate;

  _SearchBoxState():super();

  @override
  void initState() {
    super.initState();
    _delegate = _MySearchDelegate(drafts);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 38,
      margin: new EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: new EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchView()));
        },
        child: TextField(
          readOnly: true,
          onTap: () async {
            final String selected = await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              if (selected != null) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You have selected the word: $selected'),
                  ),
                );
              }
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => SearchView()));
          },
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              hintText: 'search',
              hintStyle: TextStyle(color: Colors.grey[600]),
              prefixIcon: Hero(
                  tag: 'ico',
                  child: Icon(Icons.search, size: 28, color: Theme.of(context).accentColor))),
        ),
      ),
    );
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
  final List<Draft> _drafts;
  final List<Draft> _history;

  _MySearchDelegate(List<Draft> drafts)
      : _drafts = drafts,
        _history = <Draft>[],
        super();

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        this.close(context, null);
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('You have selected the word:'),
            GestureDetector(
              onTap: () {
                // Returns this.query as result to previous screen, c.f.
                // `showSearch()` above.
                this.close(context, this.query);
              },
              child: Text(
                this.query,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<Draft> suggestions = this.query.isEmpty
        ? _history
        : this._drafts.where((dr) => dr.title.startsWith(query));

    return _SuggestionList(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        // this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                this.query = 'TODO: implement voice input';
              },
            )
          : IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<Draft> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle2;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i].title;
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          // Highlight the substring that matched the query.
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: textTheme.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: textTheme,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

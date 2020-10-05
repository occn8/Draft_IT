import 'package:Draft_IT/index.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key key,
  }) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  _SearchBoxState() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 38,
      margin: new EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: new EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchView()));
          },
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              hintText: 'search',
              hintStyle: TextStyle(color: Colors.grey[600]),
              prefixIcon: Hero(
                  tag: 'ico',
                  child: Icon(Icons.search,
                      size: 28, color: Theme.of(context).primaryColor))),
        ),
      ),
    );
  }
}

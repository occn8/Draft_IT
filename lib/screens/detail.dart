import 'package:Draft_IT/index.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) => InkWell(
                  splashColor: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: Container(
                    // margin: new EdgeInsets.all(5),
                    padding: new EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Icon(Icons.arrow_back_ios,
                        size: 25, color: Colors.black),
                  ),
                ),
              ),
              Text('title'),
              Builder(
                builder: (context) => InkWell(
                  splashColor: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {},
                  child: Container(
                    margin: new EdgeInsets.all(5),
                    padding: new EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: new Icon(Icons.star, size: 25, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

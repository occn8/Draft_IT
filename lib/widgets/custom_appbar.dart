import 'package:Draft_IT/index.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData leadIcon, trailIcon;
  final Function leadOnTap, trailOnTap;

  const CustomAppBar({
    @required this.title,
    @required this.leadOnTap,
    @required this.leadIcon,
    this.trailOnTap,
    this.trailIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => InkWell(
              splashColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
              onTap: leadOnTap,
              child: Container(
                // margin: new EdgeInsets.all(5),
                padding: new EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new Icon(leadIcon,
                    size: 25, color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          Builder(
            builder: (context) => InkWell(
              splashColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
              onTap: trailOnTap,
              child: Container(
                margin: new EdgeInsets.all(5),
                padding: new EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new Icon(trailIcon,
                    size: 25, color: Theme.of(context).primaryColorDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

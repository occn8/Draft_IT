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
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new Icon(leadIcon, size: 25, color: Colors.black),
              ),
            ),
          ),
          Text(title),
          Builder(
            builder: (context) => InkWell(
              splashColor: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
              onTap: trailOnTap,
              child: Container(
                margin: new EdgeInsets.all(5),
                padding: new EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new Icon(trailIcon, size: 25, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
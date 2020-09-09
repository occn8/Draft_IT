import 'package:Draft_IT/index.dart';

class ItemTile extends StatelessWidget {
  final String title, subtitle, date, time;
  // final DateTime dateTime;
  final Color color;
  final Function ontap;

  const ItemTile(
      {this.title,
      this.subtitle,
      this.color,
      this.ontap,
      this.date,
      this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: Row(
        children: [
          Container(
            color: Colors.transparent,
            child: ActiveStatus(),
          ),
          InkWell(
            onTap: ontap,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.93,
              // padding: EdgeInsets.all(5),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TagCircle(color: color),
                          SizedBox(height: 5),
                          Container(
                            child: Text(''),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    title ?? 'No Title Added',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  date,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.76,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                    child: Text(
                                      subtitle ?? 'No Description Added',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(width: 5),
                                Text(
                                  time,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

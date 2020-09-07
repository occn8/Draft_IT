import 'package:Draft_IT/index.dart';
import 'package:Draft_IT/widgets/tag_circle.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final String title, subtitle;
  // final DateTime dateTime;
  final Color color;
  final Function ontap;

  const ItemTile({this.title, this.subtitle, this.color, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            color: Colors.transparent,
            child: ActiveStatus(),
          ),
          InkWell(
            onTap: ontap,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.93,
              // padding: EdgeInsets.all(5),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TagCircle(color: color),
                        ],
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title ?? 'No Title',
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                                child: Text(
                              subtitle ?? 'No Description Added',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('7/10/20'),
                          Text('17:08'),
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

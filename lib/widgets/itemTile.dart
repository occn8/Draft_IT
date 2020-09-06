import 'package:Draft_IT/widgets/tag_circle.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            color: Colors.blueGrey,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  color: Colors.black,
                ),
                SizedBox(height: 15),
                Container(
                  width: 10,
                  height: 10,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            // padding: EdgeInsets.all(5),
            child: Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TagCircle(),
                      ],
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.54,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TiTle sumn'),
                          Text('description here..'),
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
        ],
      ),
    );
  }
}

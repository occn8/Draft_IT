import 'package:Draft_IT/index.dart';
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
            color: Colors.transparent,
            child: ActiveStatus(),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.93,
            // padding: EdgeInsets.all(5),
            child: Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TagCircle(),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
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

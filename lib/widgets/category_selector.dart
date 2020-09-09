import 'package:flutter/material.dart';

class PgStateSelector extends StatefulWidget {
  final List<String> pgStates;
  PgStateSelector({@required this.pgStates});
  @override
  _PgStateSelectorState createState() => _PgStateSelectorState();
}

class _PgStateSelectorState extends State<PgStateSelector> {
  int currentIndex = 0;
  bool isSelected;

  List<Widget> categorySelector() {
    List<Widget> pgStateItemList = List();

    for (int i = 0; i < widget.pgStates.length; i++) {
      isSelected = currentIndex == i;

      pgStateItemList.add(pgStateItem(
        state: widget.pgStates[i],
        isSelected: isSelected,
        ontap: () {
          setState(() {
            currentIndex = i;
          });
        },
      ));
    }
    return pgStateItemList;
  }

  Widget pgStateItem({String state, bool isSelected, Function ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // width: 90,
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 0),
              shape: BoxShape.rectangle),
          child: Column(
            children: [
              Container(
                // width: double.infinity,
                // height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black38,
                  //     offset: Offset(0, 5.0),
                  //     blurRadius: 5.0,
                  //   ),
                  // ],
                ),
                child: Text(
                  state,
                  style: isSelected
                      ? TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).accentColor)
                      : TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                height: 8.0,
                width: isSelected ? 24.0 : 16.0,
                decoration: BoxDecoration(
                  color:
                      isSelected ? Theme.of(context).accentColor : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categorySelector(),
    );
  }
}

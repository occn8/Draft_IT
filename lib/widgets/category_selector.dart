import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<Color> colors;
  CategorySelector({@required this.colors});
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int currentIndex = 0;
  bool isSelected;

  List<Widget> categorySelector() {
    List<Widget> categoryItemList = List();

    for (int i = 0; i < widget.colors.length; i++) {
      isSelected = currentIndex == i;

      categoryItemList.add(categoryItem(
        color: widget.colors[i],
        isSelected: isSelected,
        ontap: () {
          setState(() {
            currentIndex = i;
          });
        },
      ));
    }
    return categoryItemList;
  }

  Widget categoryItem({Color color, bool isSelected, Function ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50,
          height: 30,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 4),
              shape: BoxShape.circle),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 5.0),
                blurRadius: 5.0,
              ),
            ]),
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

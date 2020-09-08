import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final List<String> text;
  CategorySelector({@required this.text});
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int currentIndex = 0;
  bool isSelected;

  List<Widget> categorySelector() {
    List<Widget> categoryItemList = List();

    for (int i = 0; i < widget.text.length; i++) {
      isSelected = currentIndex == i;

      categoryItemList.add(categoryItem(
        text: widget.text[i],
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

  Widget categoryItem({String text, bool isSelected, Function ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // width: 90,
          height: 35,
          
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 0),
              shape: BoxShape.rectangle),
          child: Column(
            children: [
              Container(
                // width: double.infinity,
                // height: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 5.0),
                        blurRadius: 5.0,
                      ),
                    ]),
                child: Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800),),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                height: 8.0,
                width: isSelected ? 24.0 : 16.0,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue[800] : Colors.white,
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

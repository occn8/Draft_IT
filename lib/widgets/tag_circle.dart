import 'package:Draft_IT/index.dart';

class TagCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 5.0),
                blurRadius: 5.0,
              ),
            ]),
      ),
    );
  }
}

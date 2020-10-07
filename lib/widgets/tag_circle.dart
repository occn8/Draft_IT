import 'package:Draft_IT/index.dart';

class TagCircle extends StatelessWidget {
  final Color color;

  const TagCircle({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        shape: BoxShape.circle,
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 5.0),
                blurRadius: 5.0,
              ),
            ]),
      ),
    );
  }
}

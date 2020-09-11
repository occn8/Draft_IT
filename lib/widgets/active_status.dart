import 'package:Draft_IT/index.dart';

class ActiveStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Color(0xff308c98),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

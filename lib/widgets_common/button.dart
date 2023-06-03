import 'package:ecom/consts/consts.dart';

Widget button({
  required Color color,
  required Function() onPress,
  required String title,
  required Color textColor
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: Text(
      title,
      style: TextStyle(
        color: textColor,
        fontFamily: 'bold',
      ),
    ),
  );
}


import 'package:ecom/widgets_common/button.dart';
import 'package:flutter/services.dart';

import '../consts/consts.dart';

Widget exitDialog(context){
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18
        ).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.color(darkFontGrey).size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(color: redColor, onPress: (){
              SystemNavigator.pop()
;            }, title: "Yes", textColor: Colors.white),
            button(color: redColor, onPress: (){
              Navigator.pop(context);
            }, title: "No", textColor: Colors.white)
          ],
        )
      ],
    ).box.color(lightGrey).rounded.padding(EdgeInsets.all(12)).make(),
  );
}
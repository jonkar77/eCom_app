import 'package:ecom/consts/consts.dart';

Widget homeButton({required width, required height, required icon, required title, required onPress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icTodaysDeal, width: 26),
      15.heightBox,
      todayDeal.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}
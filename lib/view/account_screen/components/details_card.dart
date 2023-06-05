import 'package:ecom/consts/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
      5.heightBox,
    title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.padding(EdgeInsets.all(4)).rounded.width(
      width).height(70).color(Colors.white).make();
}

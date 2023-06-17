import 'package:ecom/consts/consts.dart';
import 'package:ecom/consts/list.dart';
import 'package:ecom/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets_common/button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
          height: 50,
          child: button(
              color: redColor,
              onPress: () {
                controller.placeMyorder(orderPaymentMethod: paymentMethod[controller.paymentIndex.value], totalAmount: controller.totalP.value);
              },
              title: 'Place my Order',
              textColor: Colors.white)),
      appBar: AppBar(
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => Column(
              children: List.generate(paymentMethodsimg.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.changePaymentIndex(index);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.paymentIndex.value == index
                          ? redColor
                          : Colors.transparent,
                      width: 4,
                    )),
                margin: const EdgeInsets.only(bottom: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      paymentMethodsimg[index],
                      width: double.infinity,
                      height: 120,
                      colorBlendMode: controller.paymentIndex.value==index? BlendMode.darken :BlendMode.color,
                      color: controller.paymentIndex.value==index? Colors.black.withOpacity(0.3) : Colors.transparent,
                      fit: BoxFit.cover,
                    ),
                    controller.paymentIndex.value == index
                        ? Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                value: true,
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onChanged: (value) {}),
                          )
                        : Container(),
                    Positioned(bottom:0,
                        right: 10,
                        child: paymentMethod[index].text.white.make())
                  ],
                ),
              ),
            );
          })),
        ),
      ),
    );
  }
}

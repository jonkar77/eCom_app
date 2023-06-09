import 'package:ecom/consts/consts.dart';
import 'package:ecom/view/cart_screen/payment_screen.dart';
import 'package:ecom/widgets_common/button.dart';
import 'package:ecom/widgets_common/custom_txtfield.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/cart_controller.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
          height: 50,
          child: button(color: redColor, onPress: (){
            if(controller.addressController.text.length > 10){
              Get.to(()=>PaymentScreen());
            }
            else
            {
              VxToast.show(context, msg: "Please fill the form");
            }

          }, title: 'Continue', textColor: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTxtField(hint: "Address", title: "Address", isPass: false, controller: controller.addressController),
            customTxtField(hint: "City", title: "City",isPass: false,controller: controller.cityController),
            customTxtField(hint: "State", title: "State",isPass: false,controller: controller.stateController),
            customTxtField(hint: "Postal Code", title: "Postal Code",isPass: false,controller: controller.postalController),
            customTxtField(hint: "Phone", title: "Phone",isPass: false, controller: controller.phoneController)
          ],
        ),
      ),

    );
  }
}

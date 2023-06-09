import 'package:ecom/consts/consts.dart';
import 'package:ecom/consts/list.dart';

import '../../widgets_common/button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
          height: 50,
          child: button(
              color: redColor,
              onPress: () {},
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
        child: Column(
            children: List.generate(paymentMethodsimg.length, (index) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: redColor,
                  style: BorderStyle.solid,
                  width: 5,
                )),
            margin: const EdgeInsets.only(bottom: 8),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(
                  paymentMethodsimg[index],
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(value: true,
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      onChanged: (value){}),
                )
              ],
            ),
          );
        })),
      ),
    );
  }
}

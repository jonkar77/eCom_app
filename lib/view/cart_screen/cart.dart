import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controller/cart_controller.dart';
import 'package:ecom/services/firestore_services.dart';
import 'package:ecom/widgets_common/button.dart';
import 'package:ecom/widgets_common/loading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                leading: Image.network("${data[index]['img']}"),
                                title: "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                subtitle: "${data[index]['tprice']}"
                                    .numCurrency
                                    .text
                                    .size(14)
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDoc(data[index].id);
                                }));
                          }),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(Colors.redAccent)
                              .make(),
                        )
                      ],
                    )
                        .box
                        .color(Colors.orangeAccent)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .padding(EdgeInsets.all(12))
                        .make(),
                    10.heightBox,
                    SizedBox(
                      width: context.screenWidth - 60,
                      child: button(
                          color: redColor,
                          onPress: () {},
                          title: "Proceed to shipping",
                          textColor: Colors.white),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/controller/product_controller.dart';
import 'package:ecom/services/firestore_services.dart';
import 'package:ecom/view/category_screen/item_details.dart';
import 'package:ecom/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../widgets_common/loading.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.fontFamily(bold).white.make(),
            ),
            body: StreamBuilder(
                stream: FirestoreServices.getProducts(title),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child:
                          "No products found".text.color(darkFontGrey).make(),
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  controller.subcat.length,
                                  (index) => "${controller.subcat[index]}"
                                      .text
                                      .size(12)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .makeCentered()
                                      .box
                                      .white
                                      .rounded
                                      .size(120, 60)
                                      .margin(
                                          EdgeInsets.symmetric(horizontal: 4))
                                      .make()),
                            ),
                          ),
                          20.heightBox,
                          Expanded(
                            child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          data[index]['p_imgs'][0],
                                          height: 100,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                        "${data[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "${data[index]['p_price']}"
                                            .numCurrency
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make(),
                                        10.heightBox,
                                      ],
                                    )
                                        .box
                                        .white
                                        .margin(
                                            EdgeInsets.symmetric(horizontal: 4))
                                        .rounded
                                        .outerShadow
                                        .padding(EdgeInsets.all(12))
                                        .make()
                                        .onTap(() {
                                          controller.checkIfFav(data[index]);

                                      Get.to(() =>
                                          ItemDetails(title: "${data[index]['p_name']}", data: data[index]));
                                    }),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}

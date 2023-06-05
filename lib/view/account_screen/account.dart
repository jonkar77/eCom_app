import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/consts/list.dart';
import 'package:ecom/controller/auth_controller.dart';
import 'package:ecom/services/firestore_services.dart';
import 'package:ecom/view/account_screen/components/details_card.dart';
import 'package:ecom/view/account_screen/profile_screen.dart';
import 'package:ecom/view/auth_screen/login_screen.dart';
import 'package:ecom/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/consts.dart';
import '../../controller/profile_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileContoller());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                      child: Column(
                        children: [
                          //edit profile button

                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )).onTap(() {
                                controller.nameController.text = data['name'];
                                controller.passController.text =
                                    data['password'];

                                Get.to(() => EditProfile(data: data));
                              })),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [

                                data['imageUrl']==''?
                                Image.asset(imgProfile2,
                                        width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make():
                                Image.network(data['imageUrl'],
                                    width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "${data['name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(Colors.white)
                                        .make(),
                                    "${data['email']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(Colors.white)
                                        .make(),
                                  ],
                                )),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                      color: Colors.white,
                                    )),
                                    onPressed: () async {
                                      await Get.put(AuthController())
                                          .signoutMethod(context);
                                      Get.offAll(() => const LoginScreen());
                                    },
                                    child: logout.text
                                        .fontFamily(bold)
                                        .white
                                        .make())
                              ],
                            ),
                          ),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: data['cart_count'],
                                  title: "in your cart",
                                  width: context.screenWidth / 3.3),
                              detailsCard(
                                  count: data['wishlist'],
                                  title: "in your wishlist",
                                  width: context.screenWidth / 3.3),
                              detailsCard(
                                  count: data['order'],
                                  title: "in your orders",
                                  width: context.screenWidth / 3.3),
                            ],
                          ),

                          30.heightBox,
                          ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      leading: Image.asset(
                                          profileButtonIcon[index],
                                          width: 22),
                                      title: "${profileButtonList[index]}"
                                          .text
                                          .make(),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: lightGrey,
                                    );
                                  },
                                  itemCount: profileButtonList.length)
                              .box
                              .padding(EdgeInsets.symmetric(horizontal: 16))
                              .margin(EdgeInsets.all(16))
                              .rounded
                              .shadowSm
                              .color(Colors.white)
                              .make()
                              .box
                              .color(redColor)
                              .make(),
                        ],
                      ),
                    );
                  }
                })));
  }
}

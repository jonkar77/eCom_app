import 'dart:io';
import 'package:ecom/consts/consts.dart';
import 'package:ecom/controller/profile_controller.dart';
import 'package:ecom/widgets_common/bg_widget.dart';
import 'package:ecom/widgets_common/button.dart';
import 'package:ecom/widgets_common/custom_txtfield.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;

  const EditProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileContoller>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //if data image url and controller path is empty
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
            //if data is not empty but controller path is empty
                : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(data['imageUrl'],
                            width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
            //if both are empty
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            button(
                color: redColor,
                onPress: () {
                  controller.changeImage(context);
                  // Get.find<ProfileContoller>().changeImage(context);
                },
                title: "Change",
                textColor: Colors.white),
            Divider(),
            20.heightBox,
            customTxtField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            customTxtField(
                controller: controller.passController,
                hint: passHint,
                title: password,
                isPass: true),
            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: button(
                        color: redColor,
                        onPress: () async {
                          controller.isloading(true);
                          await controller.uploadProfileImage();
                          await controller.updateProfile(
                              name: controller.nameController.text,
                              password: controller.passController.text,
                              imgUrl: controller.profileImgLink);
                          VxToast.show(context, msg: 'Uploaded');
                        },
                        title: "Save",
                        textColor: Colors.white))
          ],
        )
            .box
            .white
            .shadowSm
            .rounded
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}

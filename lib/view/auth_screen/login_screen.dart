import 'package:ecom/consts/consts.dart';
import 'package:ecom/consts/list.dart';
import 'package:ecom/controller/auth_controller.dart';
import 'package:ecom/view/auth_screen/signup_screen.dart';
import 'package:ecom/view/home_screen/home.dart';
import 'package:ecom/view/home_screen/home_screen.dart';
import 'package:ecom/widgets_common/bg_widget.dart';
import 'package:ecom/widgets_common/applogo_widget.dart';
import 'package:ecom/widgets_common/button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets_common/custom_txtfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controlle = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  customTxtField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controlle.emailController),
                  customTxtField(
                      hint: passHint,
                      title: password,
                      isPass: true,
                      controller: controlle.passwordController),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  controlle.isloading.value
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                      : button(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controlle.isloading(true);

                            await controlle
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              }else{
                                controlle.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  Text("or"),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  button(
                      color: Colors.amberAccent,
                      title: signup,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}

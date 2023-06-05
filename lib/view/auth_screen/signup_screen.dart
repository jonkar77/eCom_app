import 'package:ecom/controller/auth_controller.dart';
import 'package:ecom/view/home_screen/home.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/custom_txtfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordReController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            10.heightBox,
            Obx(()=>
               Column(
                children: [
                  customTxtField(
                      hint: nameHint, title: name, controller: nameController, isPass: false),
                  customTxtField(
                      hint: emailHint, title: email, controller: emailController, isPass: false),
                  customTxtField(
                      hint: passHint,
                      title: password,
                      controller: passwordController, isPass: true),
                  customTxtField(
                      hint: passHint,
                      title: rePass,
                      controller: passwordReController, isPass: true),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          },
                          checkColor: redColor),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: "Terms and Conditions",
                              style: TextStyle(
                                fontFamily: bold,
                                color: redColor,
                              )),
                          TextSpan(
                              text: " &",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: " Privacy Policy",
                              style: TextStyle(
                                fontFamily: bold,
                                color: redColor,
                              )),
                        ])),
                      )
                    ],
                  ),
                  controller.isloading.value
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ):
                  button(
                          color: isCheck == true ? redColor : Colors.amberAccent,
                          title: signup,
                          textColor: Colors.white,
                          onPress: () async {
                            if(isCheck!=false){
                              controller.isloading(true);
                              try{
                                await controller.signupMethod(
                                  context: context, email: emailController.text, password: passwordController.text,
                                ).then((value){
                                  return controller.storeUserData(nameController.text, emailController.text, passwordController.text);
                                }).then((value){
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(()=>Home());
                                });

                              } catch(e){
                                VxToast.show(context, msg: e.toString());
                                auth.signOut();
                                controller.isloading(false);

                              }
                            }
                          })
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: alreadyHaveAcc,
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          )),
                    ],
                  )).onTap(() {
                    Get.back();
                  })
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

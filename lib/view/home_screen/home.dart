import 'package:ecom/consts/consts.dart';
import 'package:ecom/controller/home_controller.dart';
import 'package:ecom/view/account_screen/account.dart';
import 'package:ecom/view/cart_screen/cart.dart';
import 'package:ecom/view/category_screen/category.dart';
import 'package:ecom/view/home_screen/home_screen.dart';
import 'package:ecom/widgets_common/exit_dialogue.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CatScreen(),
      const CartScreen(),
      const AccountScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.currNavIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            items: navbarItem,
            onTap: (value) {
              controller.currNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}

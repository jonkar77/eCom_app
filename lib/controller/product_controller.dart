import 'package:ecom/consts/consts.dart';
import 'package:ecom/models/category_models.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];

  var quantity = 0.obs;
  var colorInd = 0.obs;
  var totalPrice = 0.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategories) {
      subcat.add(e);
    }
  }

  changeColorInd(index) {
    colorInd = index;
  }

  increaseQuant(totalQuantity) {
    if (quantity.value < totalQuantity) quantity.value++;
  }

  decreaseQuant() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, color, qty, tprice, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'qty': qty,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }
  resetValue(){
    totalPrice.value=0;
    quantity.value=0;
    colorInd.value=0;
  }

}

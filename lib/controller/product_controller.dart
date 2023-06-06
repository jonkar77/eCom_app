import 'package:ecom/models/category_models.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
var subcat=[];

    var quantity=0.obs;
    var colorInd= 0.obs;
  getSubCategories(title) async{
    subcat.clear();
    var data=await rootBundle.loadString("lib/services/category_model.json");
    var decoded= categoryModelFromJson(data);
    var s= decoded.categories.where((element) => element.name==title).toList();

    for( var e in s[0].subcategories){
      subcat.add(e);
    }

  }

  changeColorInd(index){
    colorInd=index;
  }

}
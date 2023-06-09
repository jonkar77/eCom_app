import 'package:ecom/consts/consts.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var totalP=0.obs;

  //text controllers for shipping details

  var addressController= TextEditingController();
  var cityController= TextEditingController();
  var postalController= TextEditingController();
  var phoneController= TextEditingController();
  var stateController= TextEditingController();


  calculate(data){
    totalP.value=0;
    for(var i=0; i<data.length; i++)
      {
        totalP.value+=int.parse(data[i]['tprice'].toString());
      }
  }
}
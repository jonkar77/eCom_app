import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/consts/consts.dart';
import 'package:ecom/controller/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var totalP=0.obs;

  //text controllers for shipping details

  var addressController= TextEditingController();
  var cityController= TextEditingController();
  var postalController= TextEditingController();
  var phoneController= TextEditingController();
  var stateController= TextEditingController();
var paymentIndex=0.obs;


late dynamic productSnapshot;
var products=[];
  calculate(data){
    totalP.value=0;
    for(var i=0; i<data.length; i++)
      {
        totalP.value+=int.parse(data[i]['tprice'].toString());
      }
  }


  changePaymentIndex(index){
    paymentIndex.value=index;
  }

  placeMyorder({required orderPaymentMethod, totalAmount}) async{

    await getProductdetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_date': FieldValue.serverTimestamp(),
      'order_code': "23352108",
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postal': postalController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'order': FieldValue.arrayUnion(products),
    });
  }


  getProductdetails(){
    for(var i=0; i<productSnapshot.length; i++){
      products.add(
        {
          'color': productSnapshot[i]['color'],

          'img': productSnapshot[i]['img'],
          'qty': productSnapshot[i]['qty'],
          'title': productSnapshot[i]['title']
        }
      );
    }
  }
}


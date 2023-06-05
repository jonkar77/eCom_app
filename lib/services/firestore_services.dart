import 'package:ecom/consts/consts.dart';
//get users data
class FirestoreServices {
  static getUser(uid){
    return firestore.collection(userCollection).where('id', isEqualTo: uid).snapshots();
  }
}
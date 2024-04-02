import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MediaController extends GetxController{

  String? name;
  String? image;
  List<QueryDocumentSnapshot>  argsList=[];
  @override
  void onInit() {
    super.onInit();
    var args= Get.arguments as List;
    argsList=args[0] as List<QueryDocumentSnapshot>;
    name=args[1] as String?;
   // var data= args[0] as QueryDocumentSnapshot;
   // var userData=data.data() as Map<String,dynamic>?;

  }

}
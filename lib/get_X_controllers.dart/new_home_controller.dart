import 'package:get/get.dart';

class NewHomeController extends GetxController {
  var isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }
}

import 'package:a2/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class homeController extends GetxController {
  home();
  goTosettinge();
}

class homeControllerimp extends homeController {
  @override
  home() {}

  @override
  goTosettinge() {
    Get.toNamed(AppRoute.settinge);
  }
}

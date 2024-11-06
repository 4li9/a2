import 'package:a2/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class settingeController extends GetxController {
  settinge();
  goToCurrencySelection();
}

class settingeControllerimp extends settingeController {
  @override
  settinge() {}

  @override
  goToCurrencySelection() {
    Get.toNamed(AppRoute.CurrencySelection);
  }
}

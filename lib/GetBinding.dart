import 'package:electricbuy/views/dashboardpage/dashboardController.dart';
import 'package:get/get.dart';

class GetBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DashboardController());
  }
}

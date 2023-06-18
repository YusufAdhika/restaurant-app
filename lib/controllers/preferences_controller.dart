import 'package:get/get.dart';
import 'package:restaurant_api/data/preferences/sharedreferences_helper.dart';

class PreferencesController extends GetxController {
  @override
  void onInit() {
    _setDailyRemainder();
    super.onInit();
  }

  RxBool getDailyRemainder = false.obs;

  void _setDailyRemainder() async {
    getDailyRemainder.value = await SharedPreferencesHelper.getDailyReminder();
  }

  void dailyRemainder(bool value) {
    SharedPreferencesHelper.setDailyReminder(value);
    _setDailyRemainder();
  }
}

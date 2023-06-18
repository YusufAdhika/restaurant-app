import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/helper/date_time_helper.dart';
import '../helper/background_service.dart';

class SchedulingController extends GetxController {
  Future<bool> notifReminder(bool value) async {
    var state = value;
    if (state) {
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

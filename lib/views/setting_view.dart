import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/preferences_controller.dart';
import 'package:restaurant_api/controllers/scheduling_controller.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final pref = Get.put(PreferencesController());
  final sch = Get.put(SchedulingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Obx(
              () => SwitchListTile(
                title: const Text('Daily Reminder'),
                value: pref.getDailyRemainder.value,
                onChanged: (value) async {
                  sch.notifReminder(value);
                  pref.dailyRemainder(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

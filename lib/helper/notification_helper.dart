import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:restaurant_api/controllers/restaurant_controller.dart';
import 'package:restaurant_api/data/models/restaurant_model.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    List<RestaurantModel> list,
  ) async {
    const channelId = '1';
    const channelName = 'channel_01';
    const channelDescription = 'restaurant app channel';

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final controller = Get.put(RestaurantController());
    await controller.getRestaurant();
    const titleNotification = "<b>Rekomendasi restoran hari ini</b>";
    final randomIndex = Random().nextInt(controller.restaurantsList.length);
    final restaurant = controller.restaurantsList[randomIndex];
    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurant.name,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }
}

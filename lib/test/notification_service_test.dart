
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:learn_tagalog/services/notificaiton_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockNotification extends Mock implements FlutterLocalNotificationsPlugin{}

void main(){
  final MockNotification mockNotification = MockNotification();

  test('notification', () async {
    final NotificationService notificationService = NotificationService();

  });
}
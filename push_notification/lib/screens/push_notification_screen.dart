import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:push_notification/screens/SecondPage.dart';
import 'package:push_notification/widget/notification_api.dart';

class PushNotificationScreen extends StatefulWidget {
  static String channel = 'basic_channel';

  @override
  _PushNotificationScreenState createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationApi.init(initScheduled: true);

    listenNotification();

    NotificationApi.initializetimezone();
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelKey: PushNotificationScreen.channel,
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white,
              playSound: true,
              enableLights: true,
              enableVibration: true)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('push notification')),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.yellow),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25.0),
                  width: 300,
                  child: Text(
                    'Local \nNotifications',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 25),
                buildButtonContainer(
                    text: 'Simple Notificaion',
                    icon: Icon(Icons.notifications),
                    function: () {
                      return NotificationApi.showNotification(
                          id: 4,
                          title: 'reminder',
                          body: 'This is remainder about water drink water bc',
                          payload: 'water remainder');
                    }),
                buildButtonContainer(
                    text: 'Scheduled Notification',
                    icon: Icon(Icons.notifications_active),
                    function: () {
                      return NotificationApi.showScheduleNotification(
                        title: 'Dinner',
                        body: 'Today at 6 pm',
                        payload: 'Today at 6 pm',
                        scheduledDate:
                            DateTime.now().add(Duration(seconds: 12)),
                      );
                    }),
                buildButtonContainer(
                    text: 'awesomeNotification',
                    icon: Icon(Icons.notifications_active),
                    function: () {
                      return NotificationApi.awesomeNotification(
                          id: 1,
                          title: 'super women',
                          message: 'sexey super women',
                          url:
                              'https://static.episodate.com/images/tv-show/thumbnail/43234.jpg');
                    }),
                buildButtonContainer(
                    text: 'Remove Notification',
                    icon: Icon(Icons.delete_forever),
                    function: () {
                      return NotificationApi.disposeNotification();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildButtonContainer({
    required String text,
    required Icon icon,
    required Function function,
  }) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(12.0),
      child: ElevatedButton.icon(
        onPressed: function(),
        icon: icon,
        label: Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void listenNotification() {
    NotificationApi.onNotification.stream.listen((event) {
      onClickNotification(event);
    });
  }

  void onClickNotification(String? event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => SecondScreen(),
      ),
    );
  }
}

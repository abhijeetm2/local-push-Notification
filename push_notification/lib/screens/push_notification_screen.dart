import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:push_notification/screens/SecondPage.dart';
import 'package:push_notification/widget/notification_api.dart';

class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationApi.init(initScheduled: true);

    listenNotification();

    NotificationApi.initializetimezone();
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
                    text: 'Remove Notification',
                    icon: Icon(Icons.delete_forever),
                    function: () {
                      return null;
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

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import '../widget/Notification.dart';
import '../widget/tab_air.dart';
import '../widget/tab_temperature.dart';
import '../widget/tab_wet.dart';
import '../widget/controlWater.dart';
import '../widget/control.dart';
import '../widget/tab_gas.dart';
import '../widget/quat.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
class Air extends StatelessWidget {

   Air({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabAir(),
    );
  }
}

class TabAir extends StatefulWidget { 
  late final AudioPlayer audioPlayer;
  @override
  _TabAirState createState() => _TabAirState();
}

class _TabAirState extends State<TabAir> with TickerProviderStateMixin {
  
  late TabController _tabController;

 
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.animateTo(2);
    _setupGasStream();
    _setupkhiGasStream();
 Noti.initializeNotifications(flutterLocalNotificationsPlugin);
  
  }
Future<void> showNotificationWithSound() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'id1', // Thay đổi thành ID kênh thông báo của bạn
    'gas',
 playSound: true,
    importance: Importance.high,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('coi1'), // Tùy chỉnh âm thanh thông báo
  );



  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
 
  );

  await flutterLocalNotificationsPlugin.show(
    0, // ID thông báo
    'Thông báo phát hiện khí gas',
    'Mọi người cần xử lý,thoát hiểm ngay',
    platformChannelSpecifics,
    payload: 'Custom_Sound', // Payload tùy chọn để xử lý khi thông báo được nhấn
  );
}
Future<void> showNotificationWithSound1() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'id', // Thay đổi thành ID kênh thông báo của bạn
    'chay',
 playSound: true,
    importance: Importance.high,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('coi'), // Tùy chỉnh âm thanh thông báo
  );



  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
 
  );

  await flutterLocalNotificationsPlugin.show(
    0, // ID thông báo
    'Thông báo phát hiện lửa',
    'Mọi người cần xử lý,thoát hiểm ngay',
    platformChannelSpecifics,
    payload: 'Custom_Sound', // Payload tùy chọn để xử lý khi thông báo được nhấn
  );
}
  void _setupGasStream() {
    DatabaseReference gasReference =
        FirebaseDatabase.instance.ref().child('chungcu/dulieudoc/gas');

    gasReference.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          double gas = data.toDouble();

          // Kiểm tra nếu gas = 1 thì hiển thị thông báo kèm đổ chuông
          if (gas == 1) {
         showNotificationWithSound1();
            _showGasAlert();
          }
        });
      }
    });
  }
  void _setupkhiGasStream() {
    DatabaseReference gasReference1 =
        FirebaseDatabase.instance.ref().child('chungcu/dulieudoc/khigas');

    gasReference1.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          double gas = data.toDouble();

          // Kiểm tra nếu gas = 1 thì hiển thị thông báo kèm đổ chuông
          if (gas != 0) {
      showNotificationWithSound();
    _showGasAlert1();
          }
        });
      }
    });
  }
void sound() async {
  print("test1");
 AudioPlayer player = new AudioPlayer();
const alarmAudioPath = "assets/music/coi.mp3";
player.play(alarmAudioPath as Source);
}
  void _showGasAlert() {
    AssetsAudioPlayer.newPlayer().open(Audio("assets/music/coi.mp3"));
    sound();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5.0,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 48.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Cháy Rồi!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Hãy thực hiện biện pháp cứu hỏa ngay lập tức.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng hộp thoại khi người dùng bấm nút
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Màu nền của nút
                  ),
                  child: Text(
                    'Đóng',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        
      },
    );
  }
 void _showGasAlert1() {
    AssetsAudioPlayer.newPlayer().open(Audio("assets/music/coi1.mp3"));
    sound();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5.0,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 48.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Phát hiện khí gas!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Hãy thực hiện biện pháp thoát hiểm kịp thời.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng hộp thoại khi người dùng bấm nút
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Màu nền của nút
                  ),
                  child: Text(
                    'Đóng',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        
      },
    );
  }

  void updateSensorStatus(String sensorName, int newValue) {
    DatabaseReference statusSensorReference =
        FirebaseDatabase.instance.ref().child('chungcu/statusSensor');
    statusSensorReference.update({sensorName: newValue});
  }

  void updatePumpStatus(bool isPumpOn) {
    DatabaseReference statusSensorReference =
        FirebaseDatabase.instance.ref().child('chungcu/statusSensor');
    statusSensorReference.update({'bom': isPumpOn ? 1 : 0});
  }
 void updatequatStatus(bool isPumpOn) {
    DatabaseReference statusSensorReference =
        FirebaseDatabase.instance.ref().child('chungcu/statusSensor');
    statusSensorReference.update({'quat': isPumpOn ? 1 : 0});
  }
  static const List<Tab> _tabs = [
    // Tab(icon: Icon(Icons.air), child: Text('Không khí')),
    Tab(icon: Icon(Icons.water_drop_outlined), text: 'Độ ẩm'),
    Tab(icon: Icon(Icons.thermostat), text: 'Nhiệt độ'),
    Tab(icon: Icon(Icons.grain_sharp), text: 'gas'),
    Tab(icon: Icon(Icons.plumbing), text: 'Quản lý bơm'),
    Tab(icon: Icon(Icons.heat_pump), text: 'Quản lý còi'),
    // Tab(icon: Icon(Icons.control_point), text: 'control'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          labelColor: Color.fromARGB(255, 13, 99, 197),
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
          overlayColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue;
              }
              if (states.contains(MaterialState.focused)) {
                return Colors.orange;
              } else if (states.contains(MaterialState.hovered)) {
                return Colors.pinkAccent;
              }
              return Colors.transparent;
            },
          ),
          indicatorWeight: 10,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5),
          indicator: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
            color: Colors.pinkAccent,
          ),
          isScrollable: true,
          physics: BouncingScrollPhysics(),
          onTap: (int index) {
            print('Tab $index is tapped');
          },
          enableFeedback: true,
          controller: _tabController,
          tabs: _tabs,
        ),
        title: const Text(
          '\t\t\t\t\t\t\t\t\t\tChúc bạn một ngày tốt lành',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Color.fromARGB(255, 241, 241, 241),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Center(
          //   child: wigetAir(),
          // ),
          Center(
            child: wigetWet(),
          ),
          Center(
            child: TabTemperature(),
          ),
          Center(
            child: GasScreen(),
          ),
          Center(
            child: WaterPumpControlScreen(
              updatePumpStatusCallback: updatePumpStatus,
            ),
          ),
          Center(
            child: Quat(updateQuatStatusCallback: updatequatStatus),
          ),
          // Center(
          //   child: SensorControlScreen(
          //     updateSensorStatusCallback: updateSensorStatus,
          //   ),
          // ),
        ],
      ),
    );
  }
}

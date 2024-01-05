import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WaterPumpControlScreen extends StatefulWidget {
  final Function(bool) updatePumpStatusCallback;

  WaterPumpControlScreen({required this.updatePumpStatusCallback});

  @override
  _WaterPumpControlScreenState createState() => _WaterPumpControlScreenState();
}

class _WaterPumpControlScreenState extends State<WaterPumpControlScreen> {
  bool isPumpOn = false;
  DatabaseReference _statusSensorReference =
      FirebaseDatabase.instance.ref().child('chungcu/statusSensor/bom');

  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi trạng thái bơm nước từ Firebase Realtime Database
    _statusSensorReference.onValue.listen((event) {
      setState(() {
        isPumpOn = event.snapshot.value == 1;
      });
    });
  }

  void togglePump() {
    // Đảo ngược trạng thái bơm nước
    isPumpOn = !isPumpOn;
    // Cập nhật trạng thái lên Firebase Realtime Database
    _statusSensorReference.set(isPumpOn ? 1 : 0);

    // Gửi trạng thái bơm nước cho màn hình cha
    widget.updatePumpStatusCallback(isPumpOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Điều Khiển Bơm Nước'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isPumpOn ? Icons.check_circle : Icons.cancel,
              color: isPumpOn ? Colors.green : Colors.red,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              isPumpOn ? 'Bơm Nước Đang Bật' : 'Bơm Nước Đang Tắt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isPumpOn ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                togglePump();
              },
              child: Text(
                isPumpOn ? 'Tắt Bơm Nước' : 'Bật Bơm Nước',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: isPumpOn ? Colors.red : Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

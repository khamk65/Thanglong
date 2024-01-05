import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Quat extends StatefulWidget {
  final Function(bool) updateQuatStatusCallback;

  Quat({required this.updateQuatStatusCallback});

  @override
  _QuatState createState() => _QuatState();
}

class _QuatState extends State<Quat> {
  bool isQuatOn = false;
  DatabaseReference _statusSensorReference =
      FirebaseDatabase.instance.ref().child('chungcu/statusSensor/quat');

  @override
  void initState() {
    super.initState();
    // Lắng nghe thay đổi trạng thái bơm nước từ Firebase Realtime Database
    _statusSensorReference.onValue.listen((event) {
      setState(() {
        isQuatOn = event.snapshot.value == 1;
      });
    });
  }

  void toggleQuat() {
    // Đảo ngược trạng thái bơm nước
    isQuatOn = !isQuatOn;
    // Cập nhật trạng thái lên Firebase Realtime Database
    _statusSensorReference.set(isQuatOn ? 1 : 0);

    // Gửi trạng thái bơm nước cho màn hình cha
    widget.updateQuatStatusCallback(isQuatOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Điều Khiển còi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isQuatOn ? Icons.check_circle : Icons.cancel,
              color: isQuatOn ? Colors.green : Colors.red,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              isQuatOn ? 'còi đang tật' : 'còi đang tắt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isQuatOn ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                toggleQuat();
              },
              child: Text(
                isQuatOn ? 'Tắt còi' : 'Bật còi',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: isQuatOn ? Colors.red : Colors.green,
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

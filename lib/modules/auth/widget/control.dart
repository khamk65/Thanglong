import 'package:flutter/material.dart';

class SensorControlScreen extends StatefulWidget {
  final Function(String, int) updateSensorStatusCallback;

  SensorControlScreen({required this.updateSensorStatusCallback});

  @override
  _SensorControlScreenState createState() => _SensorControlScreenState();
}

class _SensorControlScreenState extends State<SensorControlScreen> {
  Set<String> selectedSensors = {}; // Danh sách các cảm biến được chọn
  List<String> sensors = ['Không Khí', 'Nhiệt Độ', 'Độ Ẩm', 'Khí Gas'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Điều Khiển Cảm Biến'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Nút chuyển đổi giữa các cảm biến (2 hàng)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      buildSensorButton(sensors[0]),
                      buildSensorButton(sensors[1]),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      buildSensorButton(sensors[2]),
                      buildSensorButton(sensors[3]),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Hiển thị các cảm biến được chọn
              Text(
                'Cảm Biến: ${selectedSensors.isEmpty ? 'Chưa chọn' : selectedSensors.join(', ')}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // Giao diện điều khiển cảm biến có thể được thêm ở đây
            ],
          ),
        ),
      ),
    );
  }

  // Widget cho nút chuyển đổi cảm biến
  Widget buildSensorButton(String sensorName) {
    bool isSelected = selectedSensors.contains(sensorName);

    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (isSelected) {
            selectedSensors.remove(sensorName);
          } else {
            selectedSensors.add(sensorName);
          }

          // Cập nhật trạng thái lên Firebase Realtime Database
          widget.updateSensorStatusCallback(sensorName, isSelected ? 0 : 1);
        });
      },
      child: Text(
        sensorName,
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.blue : Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

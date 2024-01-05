import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TabTemperature extends StatefulWidget {
  @override
  _TabTemperatureState createState() => _TabTemperatureState();
}

class _TabTemperatureState extends State<TabTemperature> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('chungcu/dulieudoc');

  double? nhietdo;

  @override
  void initState() {
    super.initState();
    _setupStream();
  }

  void _setupStream() {
    _databaseReference.child('nhietdo').onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          nhietdo = data.toDouble();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double temperature = nhietdo ?? 0.0;

    return Column(
      children: [
        SizedBox(height: 24),
        SfLinearGauge(
          labelFormatterCallback: (label) {
            if (label == 0) {
              return 'Start';
            }
            if (label == 15) {
              return 'Cold';
            }
            if (label == 25) {
              return 'Cool';
            }
            if (label == 35) {
              return 'High';
            }
            if (label == 50) {
              return 'Very High';
            }
            return label.toString();
          },
          minimum: 0,
          maximum: 50,
          axisTrackStyle: LinearAxisTrackStyle(
            thickness: 20,
            edgeStyle: LinearEdgeStyle.bothCurve,
          ),
          markerPointers: [
            LinearShapePointer(
              shapeType: LinearShapePointerType.diamond,
              height: 25,
              width: 25,
              value: temperature,
            )
          ],
          orientation: LinearGaugeOrientation.vertical,
          ranges: <LinearGaugeRange>[
            LinearGaugeRange(startValue: 0, endValue: 15, color: Colors.green),
            LinearGaugeRange(startValue: 15, endValue: 25, color: Colors.blue),
            LinearGaugeRange(startValue: 25, endValue: 35, color: Colors.orange),
            LinearGaugeRange(startValue: 35, endValue: 50, color: Colors.red),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Nhiệt kế',
          style: TextStyle(
            color: Color.fromARGB(255, 128, 97, 4),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text('Temperature: $temperature'),
      ],
    );
  }
}

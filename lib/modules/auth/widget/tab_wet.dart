import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class wigetWet extends StatefulWidget {
  @override
  _wigetWetState createState() => _wigetWetState();
}

class _wigetWetState extends State<wigetWet> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('chungcu/dulieudoc');

  double? doAm;

  @override
  void initState() {
    super.initState();
    _setupStream();
  }

  void _setupStream() {
    _databaseReference.child('doam').onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data != null) {
        setState(() {
          doAm = data.toDouble();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double wet = doAm ?? 0.0;

    return Column(
      children: [
        Container(
          width: 400,
          child: Column(
            children: [
              SizedBox(height: 16),
              SfRadialGauge(
                // Các thiết lập cho RadialGauge
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    interval: 10,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 20,
                        color: Color.fromRGBO(204, 154, 164, 1),
                      ),
                      GaugeRange(
                        startValue: 20,
                        endValue: 40,
                        label: 'Dry',
                        color: Color.fromRGBO(204, 154, 164, 1),
                      ),
                      GaugeRange(
                        startValue: 40,
                        endValue: 60,
                        label: 'Comfort',
                        color: Color.fromRGBO(143, 192, 192, 1),
                      ),
                      GaugeRange(
                        startValue: 60,
                        endValue: 100,
                        label: 'Wet',
                        color: Color.fromRGBO(191, 201, 220, 1),
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: wet,
                        enableAnimation: true,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          'wet: $wet',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        positionFactor: 0.5,
                        angle: 90,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Công tơ đo độ âm',
                style: TextStyle(
                  color: Color.fromARGB(255, 128, 97, 4),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

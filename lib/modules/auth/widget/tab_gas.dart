import 'package:app2/modules/auth/widget/GasChartProvider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class GasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gasChartProvider = Provider.of<GasChartProvider>(context);

    DatabaseReference _databaseReference =
        FirebaseDatabase.instance.ref().child('chungcu/dulieudoc');

    void _setupStream() {
      _databaseReference.child('khigas').onValue.listen((event) {
        final dynamic data = event.snapshot.value;

        if (data != null) {
          double gasValue = data.toDouble();
          gasChartProvider.updateGasValue(gasValue);
        }
      });
    }

    _setupStream();

    return Scaffold(
      appBar: AppBar(
        title: Text('Đo nồng độ khí gas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nồng độ khí gas: ${gasChartProvider.gasValue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 24),
            Container(
              height: 300,
              width: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: 100,
                  minY: 0,
                  maxY: 5,
                  lineBarsData: [
                    LineChartBarData(
                      spots: gasChartProvider.gasData,
                      isCurved: true,
                      colors: [Colors.blue],
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Biểu đồ nồng độ khí Gas theo thời gian thực',
              style: TextStyle(fontSize: 16, color: Color.fromRGBO(200, 100, 100, 1), fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

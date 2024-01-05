// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:cloud_firestore/cloud_firestore.dart';

class DataAir {
  final String CO2;
  final String CO;
  final String PM25;
  final String nhietdo;
  final String doam;
  DataAir({
    required this.CO2,
    required this.CO,
    required this.PM25,
    required this.nhietdo,
    required this.doam,
  });

  DataAir copyWith({
    String? CO2,
    String? CO,
    String? PM25,
    String? nhietdo,
    String? doam,
  }) {
    return DataAir(
      CO2: CO2 ?? this.CO2,
      CO: CO ?? this.CO,
      PM25: PM25 ?? this.PM25,
      nhietdo: nhietdo ?? this.nhietdo,
      doam: doam ?? this.doam,
    );
  }
  factory DataAir.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DataAir(
      CO2: data?['CO2'],
      CO: data?['CO'],
      PM25: data?['PM25'],
      nhietdo: data?['nhietdo'],
      doam: data?['doam'],
    );
  }
   Map<String, dynamic> toFirestore() {
    return {
      // ignore: unnecessary_null_comparison
      if (CO2 != null) "CO2": CO2,
      // ignore: unnecessary_null_comparison
      if (CO != null) "CO": CO,
      // ignore: unnecessary_null_comparison
      if (PM25 != null) "PM25": PM25,
      // ignore: unnecessary_null_comparison
      if (nhietdo != null) "nhietdo": nhietdo,
      // ignore: unnecessary_null_comparison
      if (doam != null) "doam": doam,
     
    };
}
}
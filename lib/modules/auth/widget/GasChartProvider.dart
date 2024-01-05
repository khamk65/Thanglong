import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class GasChartProvider extends ChangeNotifier {
  double _gasValue = 0.0;
  List<FlSpot> _gasData = [];

  double get gasValue => _gasValue;
  List<FlSpot> get gasData => _gasData;

  void updateGasValue(double value) {
    _gasValue = value;
    
    // Thêm dữ liệu mới vào danh sách và giới hạn số lượng điểm (nếu cần)
    _gasData.add(FlSpot(_gasData.length.toDouble(), value));
    
    // Giới hạn số lượng điểm (ví dụ: giữ lại 10 điểm gần nhất)
    if (_gasData.length > 50) {
      _gasData.removeAt(0);
    }

    // notifyListeners(); // Thông báo cho người nghe sự kiện về sự thay đổi trạng thái
  }
}

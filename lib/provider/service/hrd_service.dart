import 'package:flutter/cupertino.dart';
import 'package:tugas_akhir/provider/model/hrdmodel.dart';

// Provider Drawer HRD // ga ada guna //
class ServiceHrd with ChangeNotifier {
  int _index = 0;
  List<bool> _selected = [true, false, false];

  int get getIndex {
    return _index;
  }

  List<bool> get getSelect {
    return _selected;
  }

  void set setIndex(int value) {
    _index = value;
    notifyListeners();
  }

  void set setSelect(int num) {
    for (int i = 0; i < _selected.length; i++) {
      if (num == i) {
        _selected[num] = true;
      } else {
        _selected[i] = false;
      }
      notifyListeners();
    }
  }
}

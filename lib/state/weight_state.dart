import 'package:flutter/material.dart';
import 'package:provider_tracker/models/weight.dart';

class WeightState with ChangeNotifier {
  List<Weight> _weights = [
    Weight(value: 65, time: DateTime.utc(2021, 01, 04)),
    Weight(value: 67, time: DateTime.utc(2021, 02, 17)),
    Weight(value: 68, time: DateTime.utc(2021, 03, 23))
  ];

  List<Weight> get weights => _weights;

  Weight get currentWeight => _weights.first;

  add(Weight weight) {
    _weights.insert(0, weight);
    notifyListeners();
  }
}

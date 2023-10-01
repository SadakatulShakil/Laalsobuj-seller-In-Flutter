import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/model/response/upazila_model.dart';

class UpazilaProvider extends ChangeNotifier {
  List<Upazila> _upazilas = [];

  List<Upazila> get upazilas => _upazilas;

  Future<void> fetchUpazilas(int districtId) async {
    final response =
    await http.post(Uri.parse('https://laalsobuj.comjagat.org/api/totthoapa/upazilas-selected-by-district'),
        body: {'district_id': districtId.toString()});
    final data = json.decode(response.body);

    _upazilas = (data['upazila'] as List)
        .map((json) => Upazila.fromJson(json))
        .toList();

    notifyListeners();
  }

  Upazila? _selectedUpazilaObject;

  Upazila? get selectedUpazilaObject => _selectedUpazilaObject;

  void setSelectedUpazilaObject(Upazila upazila) {
    _selectedUpazilaObject = upazila;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/model/response/district_model.dart';


class DistrictProvider extends ChangeNotifier {
  List<District> _districts = [];

  List<District> get districts => _districts;

  Future<void> fetchDistricts() async {
    final response = await http.get(Uri.parse('https://laalsobuj.comjagat.org/api/totthoapa/district-list'));
    final data = json.decode(response.body);

    _districts = (data['districts'] as List)
        .map((json) => District.fromJson(json))
        .toList();

    notifyListeners();
  }
}

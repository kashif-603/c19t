import 'dart:convert';
import 'package:c19t/services/utilties/app_url.dart';
import 'package:http/http.dart' as http;

import '../model/WorldStateModel.dart';

class StateServices {
  Future<WorldStateModel> fetchrecord() async {
    final response = await http.get(Uri.parse(Appurl.WorldUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Updated fetchCountries method
  Future<List<dynamic>> fetchCountries() async {
    final response = await http.get(Uri.parse(Appurl.CountriesdUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data; // Return the list of countries directly
    } else {
      throw Exception('Failed to load countries');
    }
  }
}

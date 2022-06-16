import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/model/pharmacy_details.dart';
import '../../../utils/constants.dart' as constants;
import 'api_service.dart';

class ApiServiceImpl extends ApiService {

  @override
  Future<PharmacyDetails> getPharmacyDetails(String id) async {
    final response = await http.get(
        Uri.parse("${constants.apiUrlGetPharmacyDetails}/$id")
    );

    if (response.statusCode == 200) {
      return PharmacyDetails.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch pharmacy details');
    }
  }

  @override
  Future<List<String>> getMedications() async {
    final response = await http.get(Uri.parse(constants.apiUrlGetMedications));

    if (response.statusCode == 200) {
      return response.body.split(",\n");
    } else {
      throw Exception('Failed to fetch medications');
    }
  }
}

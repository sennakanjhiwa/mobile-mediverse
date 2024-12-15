import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/doctor.dart';

class ApiService {
  final String _url = dotenv.get('SUPABASE_URL');
  final String _anonKey = dotenv.get('SUPABASE_ANON_KEY');

  Future<List<Doctor>> fetchDoctors() async {
    final response = await http.get(
      Uri.parse(
          '$_url/rest/v1/doctors?select=*'), // Ganti dengan endpoint REST API kamu
      headers: {
        'apikey': _anonKey,
        'Authorization': 'Bearer $_anonKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Doctor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}

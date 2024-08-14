import 'dart:convert';
import 'package:benfica_social/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';


   String baseUrl='http://localhost:3000/api';
   String skeltonUrl='http://localhost:3000';

abstract class BaseService extends HttpOverrides {
  // String _bareUrl='http://localhost:3000';
  late String _baseUrl='http://localhost:3000/api';
  String? authToken;
  String? _authToken;
  // BaseService(this._baseUrl);

  BaseService() {
    initialize(); 
  }
Future<void> initialize() async { 
    var user=await getuserFromStorage();
    _authToken = user?.token;
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'),
    headers: _buildHeaders(),);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> getById(String endpoint, String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint/$id'));
    return _handleResponse(response);
  }

  Future  post(String endpoint, dynamic data) async {
   print("DATA",);
   print(data);
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      body: jsonEncode(data),
      headers: _buildHeaders(),
    );  
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } on FormatException {
      throw Exception('Invalid JSON response: ${response.body}');
    } catch (e) {
      throw Exception(response.body);
    }
  }
  String resolveException(e) {
    final errorJson = json.decode(e.toString().replaceFirst('Exception: ', ''));
    String errorMessage = errorJson['message'];
    return errorMessage;
  }
Map<String, String> _buildHeaders() {
  final headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    // print('are u running');
    // print(_authToken);
  if (_authToken != null) {
    headers['Authorization'] = 'Bearer $_authToken';
  }
  return headers;
}
  Future<User?> getuserFromStorage() async {
    //provider will use this one
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userString = localStorage.getString('user');
  //  localStorage.remove('user');
    if (userString == null) {
      return null;
    }
    var userJson = json.decode(userString);
    User user = User.fromJson(userJson);
    // user.
    return user;
  }
}

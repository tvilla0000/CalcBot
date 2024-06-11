import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  late final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> performVectorOperation(String operation, List<List<int>> vectors) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/vector/operation/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'operation': operation,
        'vectors': vectors, 
      }),
    );

    return _processResponse(response);
  }

  Future<Map<String, dynamic>> performExpressionOperation(
    String operation,
    String expression,
    String variable, {
      List<int>? limits,
    }) async {
      final response = await http.post(
        Uri.parse('$baseUrl/expression/operation/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'operation': operation,
          'expression': expression,
          'variable': variable,
          if (limits != null) 'limits': limits,
        }),
      );
      return _processResponse(response);
    }

    Map<String, dynamic> _processResponse(http.Response response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw ApiException('Failed To Perform Operation" ${response.body}');
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
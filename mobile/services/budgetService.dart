import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/model/budgetModel.dart';
import 'package:byte_blossoms/url/url.dart';

class BudgetService {
  final String baseUrl = URL.getBaseUrl();

  Future<List<BudgetDetails>> getBudgetDetailsByUserID(String userID) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getBudgets/$userID'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data.containsKey('message')) {
          print(data['message']);
          return [];
        }

        final List<dynamic> budgetsJson = data['budgets'] ?? []; 
        return budgetsJson.map((json) => BudgetDetails.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load budget details: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to fetch budget details: $e');
    }
  }
}


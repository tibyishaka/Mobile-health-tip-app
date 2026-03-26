import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final envContent = File('.env').readAsStringSync();
  final apiKey = envContent.replaceAll('GEMINI_API_KEY=', '').trim();
  print('Key starting with: ' + apiKey.substring(0, 5));
  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=' + apiKey);
  final response = await http.get(url);
  print(response.body);
}

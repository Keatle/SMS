import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final storage = const FlutterSecureStorage();

  // Using Future async since we might have to wait for the function to fetch something that is external to this project.
  Future<void> writeToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  // Reading the token
  Future<String?> readToken() async {
    return await storage.read(key: 'auth_token');
  }

  // Deleting the token
  Future<void> deleteToken() async {
    await storage.delete(key: 'auth_token');
  }

  
}

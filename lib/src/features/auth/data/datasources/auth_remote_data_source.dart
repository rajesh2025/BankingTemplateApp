import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_exceptions.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource({required this.dioClient});

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dioClient.client.post('/api/login', data: request.toJson());

      final status = response.statusCode ?? 0;
      final data = response.data;

      // Success (200/201)
      if (status >= 200 && status < 300) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(data as Map);
        return LoginResponse.fromJson(json);
      }

      // Handle client errors (401, 400 etc.)
      String serverMsg = 'Invalid credentials';
      try {
        if (data is Map && data.isNotEmpty) {
          serverMsg = data['error']?.toString() ?? data['message']?.toString() ?? data.toString();
        } else if (data != null) {
          serverMsg = data.toString();
        }
      } catch (_) {
        serverMsg = 'Invalid credentials';
      }

      if (status == 400) {
        throw NetworkException('Bad request: $serverMsg');
      } else if (status == 401) {
        throw NetworkException('Unauthorized: $serverMsg');
      } else if (status == 403) {
        throw NetworkException('Forbidden: $serverMsg');
      } else {
        throw NetworkException('Server error ($status): $serverMsg');
      }
    } on DioException catch (e) {
      // network / timeout / other Dio-level errors
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Request timed out. Check your network and try again.');
      }
      throw NetworkException(e.message ?? 'Network error');
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}
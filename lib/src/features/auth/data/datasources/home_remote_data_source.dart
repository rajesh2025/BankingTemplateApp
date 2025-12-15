// home_remote_data_source.dart
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/home_request.dart';
import '../models/home_response.dart';

class HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSource({required this.dioClient});

  /// The mock API expects token in request body, per your note.
  Future<HomeResponse> fetchHome(HomeRequest request) async {
    try {
      final resp = await dioClient.client.post('/api/home', data: request.toJson());
      final status = resp.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        return HomeResponse.fromJson(Map<String, dynamic>.from(resp.data));
      } else {
        throw Exception('Home API returned status $status: ${resp.data}');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error');
    }
  }
}
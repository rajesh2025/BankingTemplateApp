import '../datasources/home_remote_data_source.dart';
import '../models/home_request.dart';
import '../models/home_response.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl({required this.remote});

  @override
  Future<HomeResponse> getHome(HomeRequest request) {
    return remote.fetchHome(request);
  }
}
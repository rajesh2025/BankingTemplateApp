import '../../data/models/home_request.dart';
import '../../data/models/home_response.dart';
import '../repositories/home_repository.dart';

class GetHomeUseCase {
  final HomeRepository repository;
  GetHomeUseCase({required this.repository});

  Future<HomeResponse> call(HomeRequest request) => repository.getHome(request);
}
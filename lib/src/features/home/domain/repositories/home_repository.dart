import '../../data/models/home_request.dart';
import '../../data/models/home_response.dart';

abstract class HomeRepository {
  Future<HomeResponse> getHome(HomeRequest request);
}
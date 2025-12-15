// network_exceptions.dart
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Network Error']);
  @override
  String toString() => 'NetworkException: $message';
}
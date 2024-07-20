import 'package:dio/dio.dart';
import 'package:task_manager/utils/constants.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  final String baseUrl = '${Constants.baseUrl}/auth/login';

  Future<dynamic> login(String username, String password,
      {Function? onSuccess, Function? onFailure}) async {
    try {
      final response = await _dio.post(
        baseUrl,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data;
      } else {
        onFailure?.call();
        return null;
      }
    } catch (e) {
      onFailure?.call();
      return null;
    }
  }
}

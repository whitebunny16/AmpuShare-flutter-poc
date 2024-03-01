import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHelper {
  static Future<Dio> getDio() async {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: dotenv.get("API_HOST", fallback: "http://localhost:8585"), // Replace with your base URL
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 30),
    );

    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer your_token',
    // };

    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     // Handle request here (e.g., logging)
    //     handler.next(options);
    //   },
    //   onResponse: (response, handler) {
    //     // Handle response here (e.g., logging)
    //     handler.next(response);
    //   },
    //   onError: (DioError error, handler) {
    //     // Handle error here (e.g., display error message)
    //     handler.next(error);
    //   },
    // ));

    return dio;
  }
}

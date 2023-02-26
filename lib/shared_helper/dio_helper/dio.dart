import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String? url,
    Map<String, dynamic>? query,
    dynamic token,
  }) async {
    dio?.options.headers = {
      "Content-Type": "application/json",
      'lang': 'en',
      'Authorization': token ?? ''
    };
    return await dio!.get(url!, queryParameters: query);
  }

  static Future<Response> postData({
    required String? url,
    required Map<String, dynamic>? data,
    String? token,
  }) async {
    dio?.options.headers = {
      "Content-Type": "application/json",
      'lang': 'en',
      'Authorization': token ?? ''
    };
    return await dio!.post(
      url!,
      data: data,
    );
  }
}

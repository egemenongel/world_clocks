import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:world_clocks/core/constants/api_constants.dart';
import 'package:world_clocks/core/constants/enums/request_types.dart';
import 'package:world_clocks/core/utils/base/base_model.dart';

class NetworkManager {
  static NetworkManager? instance = NetworkManager.init();
  NetworkManager() {
    NetworkManager.init();
  }
  late final Dio dio;

  NetworkManager.init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      contentType: ApiConstants.json,
    ));
  }
  Future request<T extends BaseModel>({
    required RequestTypes method,
    required String path,
    dynamic data,
    required T model,
    Map<String, dynamic>? queryParameters,
    bool isBaseResponse = true,
    isFile = false,
  }) async {
    data ??= {};
    try {
      var body = data is Map || data is FormData ? data : data.toJson();

      var response = await dio.request(path,
          data: body,
          queryParameters: queryParameters,
          options: Options(
            contentType: isFile ? ApiConstants.file : ApiConstants.json,
            method: method.name,
          ));

      if (response.statusCode == 200) {
        if (response.data is List) {
          var list = <T>[];
          for (var element in (response.data as List)) {
            list.add(model.fromJson(element));
          }
          return list.isNotEmpty ? list : model;
        }
        return model.fromJson(response.data);
      } else {
        log('$path ${method.name} FAILED | Status Code: ${response.statusCode} | Status Message: ${response.statusMessage}');
        return null;
      }
    } on DioError {
      // log('$path ${method.name} DIO ERROR | Error : $dioError');
      // return _showError(dioError);
    } catch (error) {
      log('$path ${method.name} ERROR | Error : $error');
      return null;
    }
  }

  Future primitiveRequest({
    required RequestTypes method,
    required String path,
  }) async {
    try {
      var response = await dio.request(
        path,
        options: Options(method: method.name),
      );
      if (response.statusCode == 200) {
        if (response.data is List) {
          List dynamicList = response.data;
          List<String> list = dynamicList.isNotEmpty
              ? dynamicList.map((e) => e.toString()).toList()
              : [];
          return list;
        }
        return response.data;
      } else {
        log('$path ${method.name} FAILED | Status Code: ${response.statusCode} | Status Message: ${response.statusMessage}');
        return null;
      }
    } on DioError {
      // log('$path ${method.name} DIO ERROR | Error : $dioError');
      // return _showError(dioError);
    } catch (error) {
      log('$path ${method.name} ERROR | Error : $error');
      return null;
    }
  }
}

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String SERVER = ''; //服务器地址配置
int CONNECT_TIME_OUT = 1000; //连接超时时间
int SUCCESS_CODE = 0; //和后端商定的成功返回的数字码

class ZyhNetWork {
  factory ZyhNetWork() => _getInstance();
  static ZyhNetWork get instance => _getInstance();
  static ZyhNetWork _instance;
  Dio get dio => _dio;

  Dio _dio;

  ZyhNetWork._init() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
          baseUrl: SERVER,
          connectTimeout: CONNECT_TIME_OUT,
          receiveTimeout: CONNECT_TIME_OUT);

      _dio = Dio(options);

      //添加拦截器
      _dio.interceptors.add(ApiInterceptor());
    }
  }

  static ZyhNetWork _getInstance() {
    if (_instance == null) {
      _instance = ZyhNetWork._init();
    }
    return _instance;
  }

  //GET
  Future<ZyhHttpResponse> byteListGet(
      String path, Map<String, dynamic> param) async {
    ZyhHttpResponse resp = new ZyhHttpResponse();

    try {
      Map<String, dynamic> headers = {
        HttpHeaders.contentTypeHeader: ZyhHttpContentType.json
      };

      _dio.options.connectTimeout = CONNECT_TIME_OUT;
      _dio.options.headers = headers;
      Response response = await dio.get(path,
          queryParameters: param,
          options: Options(responseType: ResponseType.bytes));
      print(
          '[BYTELISTGET]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');
      resp.success = true;
      resp.message = 'success';
      resp.data = response.data;
      return resp;
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');

      if (e.response != null) {
        print(
            '[BYTELISTGET]>>${_dio.options.baseUrl}$path,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print(
            '[BYTELISTGET]>>${_dio.options.baseUrl}$path,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }
      resp.success = false;
      resp.message = HandleError.getFinalException(e);
      resp.data = [];
      return resp;
    }
  }

  Future<ZyhHttpResponse> byteListGetWithToken(
      String token, String path, Map<String, dynamic> param) async {
    ZyhHttpResponse resp = new ZyhHttpResponse();

    try {
      Map<String, dynamic> headers = {
        HttpHeaders.contentTypeHeader: ZyhHttpContentType.json
      };

      _dio.options.connectTimeout = CONNECT_TIME_OUT;
      _dio.options.headers = headers;
      Response response = await dio.get(path,
          queryParameters: param,
          options: Options(responseType: ResponseType.bytes));
      print(
          '[BYTELISTGET]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');
      resp.success = true;
      resp.message = 'success';
      resp.data = response.data;
      return resp;
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');

      if (e.response != null) {
        print(
            '[BYTELISTGET]>>${_dio.options.baseUrl}$path,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print(
            '[BYTELISTGET]>>${_dio.options.baseUrl}$path,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }
      resp.success = false;
      resp.message = HandleError.getFinalException(e);
      resp.data = [];
      return resp;
    }
  }

  Future<ZyhHttpResponse> get(String path, Map<String, dynamic> param) async {
    try {
      Map<String, dynamic> headers = {
        HttpHeaders.contentTypeHeader: ZyhHttpContentType.json
      };

      _dio.options.connectTimeout = CONNECT_TIME_OUT;
      _dio.options.headers = headers;
      if (param.isEmpty) {
        Response response = await dio.get(path);

        print(
            '[GET]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');

        return ZyhHttpResponse.fromJson(response.data);
      } else {
        Response response = await dio.get(path, queryParameters: param);

        print(
            '[GET]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');

        return ZyhHttpResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');

      if (e.response != null) {
        print('[GET]>>${_dio.options.baseUrl}$path,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print('[GET]>>${_dio.options.baseUrl}$path,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }

      return ZyhHttpResponse(
          data: {}, success: false, message: HandleError.getFinalException(e));
    }
  }

  //POST
  Future<ZyhHttpResponse> jsonPost(
      String path, Map<String, dynamic> param) async {
    return post(path, param, ZyhHttpContentType.json);
  }

  Future<ZyhHttpResponse> formPost(
      String path, Map<String, dynamic> param) async {
    return post(path, param, ZyhHttpContentType.form);
  }

  Future<ZyhHttpResponse> post(
      String path, Map<String, dynamic> param, String contentType) async {
    Map<String, dynamic> headers = {HttpHeaders.contentTypeHeader: contentType};
    _dio.options.connectTimeout = CONNECT_TIME_OUT;
    _dio.options.headers = headers;
    try {
      Response response = await _dio.post(path, data: param);
      print(
          '[POST:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');

      return ZyhHttpResponse.fromJson(response.data);
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');

      if (e.response != null) {
        print(
            '[POST:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print(
            '[POST:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }

      return ZyhHttpResponse(
          data: {}, success: false, message: HandleError.getFinalException(e));
    }
  }

  //PUT
  Future<ZyhHttpResponse> formPut(
      String path, Map<String, dynamic> param) async {
    return put(path, param, ZyhHttpContentType.form);
  }

  Future<ZyhHttpResponse> jsonPut(
      String path, Map<String, dynamic> param) async {
    return put(path, param, ZyhHttpContentType.json);
  }

  Future<ZyhHttpResponse> filePut(
      String path, Map<String, dynamic> param) async {
    String contentType = ZyhHttpContentType.multiForm;

    Map<String, dynamic> headers = {HttpHeaders.contentTypeHeader: contentType};

    _dio.options.connectTimeout = CONNECT_TIME_OUT;
    _dio.options.headers = headers;

    var formData = FormData.fromMap({
      'diskId': param['diskId'],
      'parentId': param['parentId'],
      'file':
          await MultipartFile.fromFile(param['path'], filename: param['name'])
    });

    try {
      Response response = await _dio.put(path, data: formData);
      print(
          '[PUT:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');

      return ZyhHttpResponse.fromJson(response.data);
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');

      if (e.response != null) {
        print(
            '[PUT:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print(
            '[PUT:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }
      return ZyhHttpResponse(
          data: {}, success: false, message: HandleError.getFinalException(e));
    }
  }

  Future<ZyhHttpResponse> put(
      String path, Map<String, dynamic> param, String contentType) async {
    Map<String, dynamic> headers = {HttpHeaders.contentTypeHeader: contentType};

    _dio.options.connectTimeout = CONNECT_TIME_OUT;
    _dio.options.headers = headers;
    try {
      Response response = await _dio.put(path, data: param);
      print(
          '[PUT:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');

      return ZyhHttpResponse.fromJson(response.data);
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');
      if (e.response != null) {
        print(
            '[PUT:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print(
            '[PUT:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }

      return ZyhHttpResponse(
          data: {}, success: false, message: HandleError.getFinalException(e));
    }
  }

  //DELETE
  Future<ZyhHttpResponse> delete(
      String path, Map<String, dynamic> param) async {
    String contentType = ZyhHttpContentType.json;

    Map<String, dynamic> headers = {HttpHeaders.contentTypeHeader: contentType};

    _dio.options.connectTimeout = CONNECT_TIME_OUT;
    _dio.options.headers = headers;
    try {
      Response response = await _dio.delete(path, data: param);
      print(
          '[DELETE:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[RESPONSE]>>$response');

      return ZyhHttpResponse.fromJson(response.data);
    } on DioError catch (e) {
      EasyLoading.showError('服务器错误');

      if (e.response != null) {
        print(
            '[DELETE:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.response
        }}');
      } else {
        print(
            '[DELETE:$contentType]>>${_dio.options.baseUrl}$path,[HEADER]>>$headers,[BODY]>>$param,[ERROR]>>${{
          e.message
        }}');
      }

      return ZyhHttpResponse(
          data: {}, success: false, message: HandleError.getFinalException(e));
    }
  }

  stopNetworkConnect() {
    EasyLoading.dismiss();
    _dio.close();
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data != null) {
      if (response.data is Map) {
        if (response.data['code'] != 0) {
          EasyLoading.showError(response.data['message']);
          if (response.data['code'] == 999) {}
        }
      }
    }
    super.onResponse(response, handler);
  }
}

class HandleError {
  static String getFinalException(DioError dioError) {
    print("HandleError DioError:  $dioError");
    switch (dioError.type) {
      case DioErrorType.cancel:
        return "请求取消";
      case DioErrorType.connectTimeout:
        return "连接超时";
      case DioErrorType.sendTimeout:
        return '发送超时';
      case DioErrorType.response:
        return "服务器连接中断";
      case DioErrorType.receiveTimeout:
        return "接收超时";
      case DioErrorType.other:
        String msg = '未知错误';
        if (dioError.error != null) {
          if (dioError.error is SocketException) {
            msg = "网络连接异常";
          } else {
            msg = dioError.message;
          }
        }
        return msg;
    }
  }
}

class ZyhHttpResponse {
  bool success;
  String message;
  dynamic data;

  ZyhHttpResponse({this.success, this.message, this.data});

  ZyhHttpResponse.fromJson(dynamic json) {
    success = (json['code'].toString() == SUCCESS_CODE.toString());
    message = json['message'];
    data = json['data'];
  }
}

abstract class ZyhHttpContentType {
  static const form = 'application/x-www-form-urlencoded';
  static const multiForm = 'multipart/form-data';
  static const json = 'application/json;charset=UTF-8';
}

# Zyh_Network

基于Dio封装的Flutter网络工具类

## Features
- 可复用  
- 自带解析响应类  
- 开箱即用  

## Getting Started
### Add dependency
Install [Dio](https://github.com/flutterchina/dio)
```yaml
dependencies:
  dio: ^lastest_version
```

## Examples

Performing a `GET` request:

```dart

  static Future<ZyhHttpResponse> getWithNoParam() async {
    return NetWork().get($PATH, {});
  }


  static Future<ZyhHttpResponse> getWithParam(Map<String, dynamic> param) async {
    return NetWork().get($PATH,param);
  }
```

Performing a `POST` request:

```dart
//POST FORM
static Future<ZyhHttpResponse> postForm(Map<String, dynamic> param) async {
  return ZyhNetWork().formPost($PATH, param);
}

//POST JSON
static Future<ZyhHttpResponse> postJson(Map<String, dynamic> param) async {
  return ZyhNetWork().jsonPost($PATH, param);
}
```

Performing a `PUT` request:

```dart
//PUT FORM
static Future<ZyhHttpResponse> putForm(Map<String, dynamic> param) async {
  return ZyhNetWork().formPut($PATH, param);
}

//PUT JSON
static Future<ZyhHttpResponse> jsonPut(Map<String, dynamic> param) async {
  return ZyhNetWork().jsonPut($PATH, param);
}
```

Performing a `GET` request:

```dart

  static Future<ZyhHttpResponse> getWithNoParam() async {
    return NetWork().get($PATH, {});
  }


  static Future<ZyhHttpResponse> getWithParam(Map<String, dynamic> param) async {
    return NetWork().get($PATH,param);
  }
```

Get response with bytes:

```dart
  static Future<ZyhHttpResponse> getByteList(Map<String, dynamic> param) async {
    return NetWork().byteListGet($PATH, param);
  }
```

Sending FormData:

```dart
  static Future<ZyhHttpResponse> putFileToServer(Map<String, dynamic> param) async {
    return NetWork().filePut($PATH, param);
  }
```

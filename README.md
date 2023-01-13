# Zyh_Network

一个基于Dio封装的网络管理类

## Features
- ♻️可复用   
- 🗂开箱即用  
- 🎛集成封装 
  - 网络状态  
  - 拦截器  
  - 响应类

## Getting Started
### Add dependency
Install [Dio](https://github.com/flutterchina/dio)
```yaml
dependencies:
  dio: ^lastest_version
```

### Super simple to use

Download the source code and put it in project folder `/lib`
```dart
import 'package:zyh_net_work.dart';
```
## Examples

Performing a `GET` request:

```dart
static Future<ZyhHttpResponse> getWithParam(Map<String, dynamic> param) async {
  return ZyhNetWork().get($PATH,param);
}

static Future<ZyhHttpResponse> getWithoutParam() async {
  return ZyhNetWork().get($PATH, {});
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

Performing a `DELETE` request:

```dart
static Future<ZyhHttpResponse> delete(Map<String, dynamic> param) async {
  return ZyhNetWork().delete($PATH, param);
}
```

Get response with bytes:

```dart
static Future<ZyhHttpResponse> getByteList(Map<String, dynamic> param) async {
  return ZyhNetWork().byteListGet($PATH, param);
}
```

Sending FormData:

```dart
static Future<ZyhHttpResponse> putFileToServer(Map<String, dynamic> param) async {
  return ZyhNetWork().filePut($PATH, param);
}
```
…you can make your own interface.


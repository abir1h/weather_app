import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../constants/urls.dart';
import '../utility/log.dart';
import 'app_exceptions.dart';

class Server {
  static final Server _s = Server._();
  late http.Client _client;
  static Server get instance => _s;
  Server._() {
    _client = http.Client();
    // _client = RetryClient(
    //   http.Client(),
    //   whenError: (object, e){
    //     // print(e);
    //     return true;
    //   },
    //   when: (response){
    //     print(response);
    //     return response.statusCode == 401;
    //     },
    //   onRetry: (request, response, retryCount) {
    //     print(request);
    //     print(retryCount);
    //     if (retryCount == 0 && response?.statusCode == 401) {
    //       // refresh and update the token
    //     }
    //   },
    // );
  }

  final StreamController<String> _sessionExpireStreamController =
      StreamController.broadcast();
  Stream<String> get onUnauthorizedRequest =>
      _sessionExpireStreamController.stream;

  static String get host => ApiCredential
      .baseUrl; //TODO must check is HOST url active for production build

  Future<dynamic> postRequest({
    required String url,
    required dynamic postData,
  }) async {
    try {
      var body = json.encode(postData);

      var response = await _client.post(
        Uri.parse(host + url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"Message": "Request failed! Check internet connection.", "Errors": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"Message": "Request failed! Unknown error occurred.", "Errors": "Error message"}');
    }
  }

  Future<dynamic> putRequest({
    required String url,
    required dynamic postData,
  }) async {
    try {
      var body = json.encode(postData);

      var response = await _client.put(
        Uri.parse(host + url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"Message": "Request failed! Check internet connection.", "Errors": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"Message": "Request failed! Unknown error occurred.", "Errors": "Error message"}');
    }
  }

  Future<dynamic> postRequestWithFile(
      {required String url,
      required dynamic postData,
      required List<File> files}) async {
    try {

      Uri uri = Uri.parse(host + url);
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields.addAll(postData);
      for (File file in files) {
        request.files.add(await http.MultipartFile.fromPath(
          'file[]',
          file.path,
        ));
      }
      final response = await http.Response.fromStream(await request.send());
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $postData");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"message": "Request failed! Check internet connection.", "error": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}');
    }
  }

  Future<dynamic> postRequestFormData({
    required String url,
    required Map<String, String> fields, // Custom fields passed as a Map
  }) async {
    try {

      Uri uri = Uri.parse(host + url);
      http.MultipartRequest request = http.MultipartRequest('POST', uri);

      // Setting the headers
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);

      // Adding the custom fields to the request
      request.fields.addAll(fields);

      // Sending the request and receiving the response
      final response = await http.Response.fromStream(await request.send());
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $fields");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");

      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"message": "Request failed! Check internet connection.", "error": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}');
    }
  }

  Future<dynamic> uploadFile(

      {required String url, required List<File> files}) async {
    try {

      Uri uri = Uri.parse(host + url);
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      for (File file in files) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo',
          file.path,
        ));
      }
      final response = await http.Response.fromStream(await request.send());
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"message": "Request failed! Check internet connection.", "error": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}');
    }
  }

  Future uploadProfilePicture({
    required String url,
    required File file,
  }) async {
    try {
      Uri uri = Uri.parse(host + url);

      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "multipart/form-data",
      });

      // Determine the MIME type based on the file extension
      String mimeType = 'application/octet-stream';
      if (file.path.endsWith('.jpg') || file.path.endsWith('.jpeg')) {
        mimeType = 'image/jpeg';
      } else if (file.path.endsWith('.png')) {
        mimeType = 'image/png';
      }

      var attachedFile = await http.MultipartFile.fromPath(
        'photo',
        file.path,
        contentType: MediaType.parse(mimeType), // Set the correct content type
      );

      request.files.add(attachedFile);

      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          var jsonData = jsonDecode(value);
          // Handle successful upload and response here
        });
      } else if (response.statusCode != 401) {
        // Handle non-401 errors
      } else {
        // Handle 401 error
      }
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<dynamic> getRequest({required String url}) async {
    try {

      var response = await _client.get(Uri.parse(host + url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"Message": "Request failed! Check internet connection.", "Errors": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"Message": "Request failed! Unknown error occurred.", "Errors": "Error message"}');
    }
  }

  ///Todo must be modify later
  Future<dynamic> getRequestForAuth({required String url}) async {
    try {
      var response = await _client.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"message": "Request failed! Check internet connection.", "error": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"message": "Request failed! Unknown error occurred.", "error": "Error message"}');
    }
  }

  Future<dynamic> deleteRequest({required String url}) async {
    try {

      var response = await _client.delete(Uri.parse(host + url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");
      return _returnResponse(response);
    } on SocketException catch (_) {
      return json.decode(
          '{"Message": "Request failed! Check internet connection.", "Errors": "Error message"}');
    } on Exception catch (_) {
      return json.decode(
          '{"Message": "Request failed! Unknown error occurred.", "Errors": "Error message"}');
    }
  }

  void dispose() {
    _client.close();
    _sessionExpireStreamController.close();
  }

  dynamic _returnResponse(http.Response response) {
    appPrint("------------------------------");
    appPrint("Status Code ${response.statusCode}");
    appPrint("------------------------------");
    switch (response.statusCode) {
      case 200:
        return json.decode(utf8.decode(response.bodyBytes));
      case 201:
        return json.decode(utf8.decode(response.bodyBytes));
      case 204:
        return json.decode(utf8.decode(response.bodyBytes));
      case 400:
        return json.decode(utf8.decode(response.bodyBytes));
      case 401:
        return json.decode(utf8.decode(response.bodyBytes));
      case 403:
        throw UnauthorisedException(utf8.decode(response.bodyBytes));
      case 404:
        return json.decode(utf8.decode(response.bodyBytes));
      case 422:
        return json.decode(utf8.decode(response.bodyBytes));
      case 500:
        return json.decode(utf8.decode(response.bodyBytes));
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

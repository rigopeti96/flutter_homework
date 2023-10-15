import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../main.dart';

const _baseUrl = "192.168.0.171:8080/api/";

class TraWellService{
  var _dio = Dio();

  TraWellService() {
    _dio.options.baseUrl = "http://$_baseUrl/data/2.5/";
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          print("Request: 1");
          handler.next(request);
        },
        onResponse: (response, handler) {
          print("Response: 1");
          handler.next(response);
        },
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          print("Request: 2");
          handler.next(request);
        },
        onResponse: (response, handler) {
          print("Response: 2");
          handler.next(response);
        },
      ),
    );
    _dio.interceptors.add(
        InterceptorsWrapper(
            onRequest: (request, handler){
              Map<String, String> header = {
                "Authorization": "Bearer"
              };
              request.headers.addAll(header);
              handler.next(request);
            }
        )
    );
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(onError: (error, handler) async {
        var scaffoldMessenger = scaffoldMessengerKey.currentState;
        if (scaffoldMessenger != null && scaffoldMessenger.mounted == true) {
          var snackbarResult = scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text("Hálózati hiba!"),
              action: SnackBarAction(
                label: 'RETRY',
                onPressed: () {},
              ),
              duration: Duration(seconds: 10),
            ),
          );
          var reason = await snackbarResult.closed;
          if (reason == SnackBarClosedReason.action) {
            handler.resolve(await _dio.requestOption(error.requestOptions));
            return;
          }
        }
        handler.next(error);
      }),
    );
  }
}

extension _DioRequestOption on Dio{
  Future<Response<T>> requestOption<T>(RequestOptions requestOptions){
    return request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      options: Options(
        method: requestOptions.method,
        contentType: requestOptions.contentType,
        extra: requestOptions.extra,
        followRedirects: requestOptions.followRedirects,
        headers: requestOptions.headers,
        listFormat: requestOptions.listFormat,
        maxRedirects: requestOptions.maxRedirects,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        receiveTimeout: requestOptions.receiveTimeout,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        responseType: requestOptions.responseType,
        sendTimeout: requestOptions.sendTimeout,
        validateStatus: requestOptions.validateStatus,
      ),
      queryParameters: requestOptions.queryParameters,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }
}
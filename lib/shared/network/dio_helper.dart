import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/constant.dart';

  class DioHelper{
  static late Dio? dio;

  static init(){
    BaseOptions options=BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: 20*1000,
      // receiveTimeout: 20*1000,
    );
    dio =Dio(options);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang ='en',
    String? token,
  })async{
    dio!.options.headers={
      'Content_Type':'application/json',
      'lang':'ar',
      'Authorization':token??'',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
  required String url,
  Map<String, dynamic>? query,
  Map<String, dynamic>? data,
    String lang ='ar',
    String? token,
  })async {
    dio!.options.headers = {
      'Content_Type': 'application/json',
      'lang': 'ar',
      'Authorization': token ?? '',
    };
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
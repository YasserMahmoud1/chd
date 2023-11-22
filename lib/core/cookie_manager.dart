import 'package:chd/core/function.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieManager extends Interceptor {
  String? _cookie;
  String? _xDID;
  String? _token;

  CookieManager._instance();
  static final CookieManager _internal = CookieManager._instance();
  factory CookieManager() => _internal;

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    
    if (response.statusCode == 200|| response.statusCode == 201) {
      if (response.headers.map['set-cookie'] != null) {
        if (response.headers.map['set-cookie']!.length >= 2) {
          await saveCookie(
              "${response.headers.map['set-cookie']![1]};${response.headers.map['set-cookie']![0]}");
        }
      }
    } else if (response.statusCode == 401) {
      clearCookie();
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await getCookie();
    await getToken();
    options.headers["Accept"] = "application/json";
    options.headers['Cookie'] = _cookie;
    options.headers['X-DID'] = _xDID;
    options.headers['Authorization'] = "Bearer $_token";

    return super.onRequest(options, handler);
  }

  init() async {
    _xDID = await getId();
    await getCookie();
    await getToken();
  }

  getCookie() async {
    final p = await SharedPreferences.getInstance();
    _cookie = p.getString("Cookie");
  }

  getToken() async {
    final p = await SharedPreferences.getInstance();
    _token = p.getString("Token");
  }

  Future<void> saveCookie(String s) async {
    if (_cookie != s) {
      _cookie = s;
      final p = await SharedPreferences.getInstance();
      p.setString("Cookie", s);
    }
  }

  Future<void> saveToken(String t) async {
    _token = t;
    final p = await SharedPreferences.getInstance();
    p.setString("Token", t);
  }

  void clearCookie() async {
    _cookie = null;
    final p = await SharedPreferences.getInstance();
    p.remove("Cookie");
  }

  void clearToken() async {
    _token = null;
    final p = await SharedPreferences.getInstance();
    p.remove("Token");
  }
}

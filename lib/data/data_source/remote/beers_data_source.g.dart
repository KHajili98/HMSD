// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beers_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _BeersDataSourceImpl implements BeersDataSourceImpl {
  _BeersDataSourceImpl(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<BeersModel>> fetchBeers(page, perPage) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<BeersModel>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v2/beers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => BeersModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

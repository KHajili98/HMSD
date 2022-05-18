abstract class EndPoints {
  static const String prodBaseUrl = 'https://api.punkapi.com/';
  static const String devBaseUrl = 'https://api.punkapi.com/';

  static const String _v1 = '/v1';
  static const String _v2 = '/v2';

  static const excludeEndpoints = <String>[
    beers,
  ];

  //! without token
  static const String beers = '$_v2/beers';

  //! with token

}

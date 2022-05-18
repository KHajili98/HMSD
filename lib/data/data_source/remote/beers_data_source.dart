import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/constants/endpoints.dart';
import '../../models/response/beers_model.dart';

part 'beers_data_source.g.dart';

abstract class BeersDataSource {
  Future<List<BeersModel>> fetchBeers(int page, int perPage);
}

@RestApi()
abstract class BeersDataSourceImpl implements BeersDataSource {
  factory BeersDataSourceImpl(Dio dio, {String baseUrl}) = _BeersDataSourceImpl;

  @override
  @GET(EndPoints.beers)
  Future<List<BeersModel>> fetchBeers(
    @Query("page") int page,
    @Query("per_page") int perPage,
  );
}

import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:taskk/Data/model/home/get_movies_model.dart';
import '../../../Core/constants/costants.dart';
import '../../../Core/error/faliure.dart';

abstract class HomeDataSource {
  Future<Either<Failure, GetMoviesModel>> getMovies();
}

class RemoteHomeDto implements HomeDataSource {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, GetMoviesModel>> getMovies() async {
    try {
      var isCacheExist = await APICacheManager().isAPICacheKeyExist("movies");
      if (!isCacheExist) {
        var response = await dio.get("${Constants.baseUrl}/discover/movie",
            queryParameters: {"api_key": Constants.apiKey});
        GetMoviesModel model = GetMoviesModel.fromJson(response.data);
        String jsonData = json.encode(response.data);
        APICacheDBModel cacheDBModel =
            APICacheDBModel(key: "movies", syncData: jsonData);
        await APICacheManager().addCacheData(cacheDBModel);
        print("uri HIT Remote");
        return Right(model);
      } else {
        var cacheData = await APICacheManager().getCacheData("movies");
        print("cache HIT Remote");
        Map<String, dynamic> jsonData = json.decode(cacheData.syncData);
        GetMoviesModel model = GetMoviesModel.fromJson(jsonData);
        return Right(model);
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class HomeLocalDto implements HomeDataSource {
  final Dio dio = Dio();

  @override
  Future<Either<Failure, GetMoviesModel>> getMovies() async {
    try {
      var cacheData = await APICacheManager().getCacheData("movies");
      print("cache HIT Local");
      Map<String, dynamic> jsonData = json.decode(cacheData.syncData);
      GetMoviesModel model = GetMoviesModel.fromJson(jsonData);
      return Right(model);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

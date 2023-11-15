import 'package:dartz/dartz.dart';
import 'package:taskk/Core/error/faliure.dart';
import 'package:taskk/Data/data_source/home/home_data_source.dart';
import 'package:taskk/Domain/entity/home/get_movies_entity.dart';
import 'package:taskk/Domain/repository/home/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImp(this.homeDataSource);

  @override
  Future<Either<Failure, GetMoviesEntity>> getMovies() {
    return homeDataSource.getMovies();
  }
}

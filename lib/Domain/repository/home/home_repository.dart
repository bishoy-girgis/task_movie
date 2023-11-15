import 'package:dartz/dartz.dart';

import '../../../Core/error/faliure.dart';
import '../../entity/home/get_movies_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, GetMoviesEntity>> getMovies();
}

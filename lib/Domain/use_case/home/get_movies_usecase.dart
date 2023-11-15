import 'package:dartz/dartz.dart';
import 'package:taskk/Core/error/faliure.dart';
import 'package:taskk/Domain/repository/home/home_repository.dart';

import '../../entity/home/get_movies_entity.dart';

class GetMoviesUseCase {
  HomeRepository homeRepository;

  GetMoviesUseCase(this.homeRepository);

  Future<Either<Failure, GetMoviesEntity>> execute() =>
      homeRepository.getMovies();
}

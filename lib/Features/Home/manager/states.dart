import '../../../Core/error/faliure.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class GetMoviesLoadingState extends HomeStates {}

class GetMoviesErrorState extends HomeStates {
  Failure fail;

  GetMoviesErrorState(this.fail);
}

class GetMoviesSuccessState extends HomeStates {}

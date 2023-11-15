import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taskk/Core/error/faliure.dart';
import 'package:taskk/Domain/entity/home/get_movies_entity.dart';
import 'package:taskk/Domain/use_case/home/get_movies_usecase.dart';
import 'package:taskk/Features/Home/manager/states.dart';
import '../../../Core/services/network_info.dart';
import '../../../Data/data_source/home/home_data_source.dart';
import '../../../Data/repository_imp/home/home_repository_imp.dart';
import '../../../Domain/repository/home/home_repository.dart';

class HomeCubit extends Cubit<HomeStates> {
  late HomeDataSource homeDataSource;
  HomeRepository? homeRepository;
  List<ResultMovieEntity> movies = [];

  HomeCubit() : super(HomeInitState()) {
    initializeDataSource();
  }

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  Future<void> initializeDataSource() async {
    bool isConnected = await checkConnection();
    homeDataSource = isConnected ? RemoteHomeDto() : HomeLocalDto();
    homeRepository = HomeRepositoryImp(homeDataSource);
  }

  Future<bool> checkConnection() async {
    final networkInfo = NetworkInfoImp(InternetConnectionChecker());
    var isConnected = await networkInfo.isConnected;
    return isConnected;
  }

  Future<void> getMovies() async {
    emit(GetMoviesLoadingState());
    try {
      await initializeDataSource();

      GetMoviesUseCase getMoviesUseCase = GetMoviesUseCase(homeRepository!);
      var result = await getMoviesUseCase.execute();
      result.fold(
        (l) {
          print(l.message);
          emit(GetMoviesErrorState(l));
        },
        (data) {
          movies = data.results ?? [];
          emit(GetMoviesSuccessState());
        },
      );
    } catch (e) {
      print("Error: $e");
      emit(GetMoviesErrorState(Failure(message: "An error occurred")));
    }
  }
}

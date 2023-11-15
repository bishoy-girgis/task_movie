import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskk/Core/config/page_route_name.dart';
import 'package:taskk/Domain/entity/home/get_movies_entity.dart';
import 'package:taskk/Features/Movie%20Details/pages/movie_details_screen.dart';

import '../../Features/Home/pages/home_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PageRouteName.home:
        return MaterialPageRoute<dynamic>(
            builder: (context) =>  HomeView(), settings: routeSettings);
      case PageRouteName.movieDetails:
        ResultMovieEntity? movie = routeSettings.arguments as ResultMovieEntity?;
        return MaterialPageRoute<dynamic>(
            builder: (context) => MovieDetailsScreen(movie!),
            settings: routeSettings);
      default:
        return MaterialPageRoute<dynamic>(
            builder: (context) =>  HomeView(), settings: routeSettings);
    }
  }
}

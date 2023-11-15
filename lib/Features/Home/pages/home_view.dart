import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taskk/Core/extentions/extentions.dart';
import 'package:taskk/Core/services/network_info.dart';
import 'package:taskk/Features/Home/widgets/background_blur_image.dart';
import 'package:taskk/Features/Home/widgets/circular_box.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/constants/costants.dart';
import '../../../Core/services/toast.dart';
import '../../../Core/services/utils.dart';
import '../../../Data/data_source/home/home_data_source.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
        create: (context) => HomeCubit()..getMovies(),
        child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
          if (state is GetMoviesLoadingState) {
            EasyLoading.show();
          } else if (state is GetMoviesErrorState) {
            EasyLoading.dismiss();
            errorToast(context, description: "${state.fail.message}");
          }
          EasyLoading.dismiss();
        }, builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var theme = Theme.of(context);
          var mediaQuery = MediaQuery.of(context).size;
          return Scaffold(
              body: Column(children: [
            cubit.movies.isNotEmpty
                ? ImageSlideshow(
                    width: mediaQuery.width,
                    height: mediaQuery.height,
                    initialPage: 0,
                    indicatorColor: Colors.transparent,
                    indicatorBackgroundColor: Colors.transparent,
                    indicatorPadding: 0,
                    indicatorBottomPadding: 0,
                    indicatorRadius: 0,
                    autoPlayInterval: 0,
                    isLoop: true,
                    children: cubit.movies.map((movie) {
                      return Builder(builder: (BuildContext context) {
                        return Stack(
                          children: [
                            BackgroundBlurImage(
                                imageUrl:
                                    "${Constants.imagePath}${movie.posterPath}"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${movie.title}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: theme.textTheme.headlineMedium),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    CircularBox(
                                      widget: Text(
                                          formatMovieDate(movie.releaseDate),
                                          style: theme.textTheme.bodyMedium),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CircularBox(
                                      widget: Text(movie.originalLanguage ?? "",
                                          style: theme.textTheme.bodyMedium),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 25, color: Color(0XFFFFBB3B)),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text("${movie.voteAverage}/10",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(fontSize: 14)),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text("${movie.voteCount} votes",
                                        style: theme.textTheme.bodyMedium),
                                  ],
                                ),
                                SizedBox(height: 25.h),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRouteName.movieDetails,
                                        arguments: movie);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${Constants.imagePath}${movie.posterPath}",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            ).setPadding(context,
                                vertical: 0.05, horizontal: 0.025)
                          ],
                        );
                      });
                    }).toList(),
                  )
                : Container()
          ]));
        }));
  }
}

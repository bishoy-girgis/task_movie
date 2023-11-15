import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskk/Core/extentions/extentions.dart';
import 'package:taskk/Domain/entity/home/get_movies_entity.dart';

import '../../../Core/constants/costants.dart';
import '../../../Core/services/utils.dart';

class MovieDetailsScreen extends StatelessWidget {
  ResultMovieEntity movie;

  MovieDetailsScreen(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        title: Text(movie.title ?? "", style: theme.textTheme.headlineMedium),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 22),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CachedNetworkImage(
                imageUrl: "${Constants.imagePath}${movie.backdropPath}",
                placeholder: (context, url) =>
                    const Center(child: Icon(Icons.movie_creation_outlined)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 205.h,
                  width: 135.w,
                  decoration: BoxDecoration(
                    color: theme.accentColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: "${Constants.imagePath}${movie.posterPath}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(formatMovieDate(movie.releaseDate),
                        style: theme.textTheme.bodySmall),
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
                    ).setPadding(context, vertical: 0.025),
                  ],
                ).setPadding(
                  context,
                  horizontal: 0.01,
                ),
              ],
            ),
            Divider(color: theme.accentColor, height: 1.5, thickness: 1)
                .setPadding(context, vertical: 0.03),
            Text(
              "About the movie",
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              movie.overview ?? "",
              style: theme.textTheme.bodyMedium,
            ).setPadding(context, vertical: 0.015),
          ],
        ).setPadding(context, horizontal: 0.02),
      ),
    );
  }
}

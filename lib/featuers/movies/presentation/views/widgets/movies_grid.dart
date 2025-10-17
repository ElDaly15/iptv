import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/featuers/live_tv/presentation/views/tv_player_view.dart';
import 'package:iptv/featuers/movies/presentation/manager/get_movies/get_movies_cubit.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movie_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoviesGrid extends StatelessWidget {
  final String selectedCategory;

  const MoviesGrid({super.key, required this.selectedCategory});

  int _calculateCrossAxisCount(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width >= 1600) return 6;
    if (width >= 1300) return 5;
    if (width >= 1000) return 4;
    if (width >= 700) return 3;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = _calculateCrossAxisCount(context);
    return BlocBuilder<GetMoviesCubit, GetMoviesState>(
      builder: (context, state) {
        if (state is GetMoviesLoading || state is GetMoviesError || state is GetMoviesInitial) {
          return Skeletonizer(
            
            effect: ShimmerEffect(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              duration: const Duration(seconds: 1),
            ),
            enabled: true,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return MovieCard(title: 'Loading...', imageUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQYq7Mk3_qT905pUYNwN5JfQjLJoNx6n5iqB2M9iJ5MffZmKLPklzmAUJVs7P2VgVS5gspq3Q');
              },
            ),
          );
        }

      
        

        if (state is GetMoviesSuccess) {
          final items = state.moviesContentResponse.content;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final movie = items[index];
              return InkWell(
                onTap: () {
                  g.Get.to(
                    () => TvPlayerView(
                      channelName: movie.name,
                      streamUrl: movie.streamUrl,
                    ),
                    transition: g.Transition.fade,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: MovieCard(title: movie.name, imageUrl: movie.icon),
              );
            },
          );
        }

          return Skeletonizer(
            effect: ShimmerEffect(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              duration: const Duration(seconds: 1),
            ),
            enabled: true,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                return MovieCard(title: 'Loading...', imageUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQYq7Mk3_qT905pUYNwN5JfQjLJoNx6n5iqB2M9iJ5MffZmKLPklzmAUJVs7P2VgVS5gspq3Q');
              },
            ),
          );
      },
    );
  }
}

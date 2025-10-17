import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:iptv/featuers/live_tv/presentation/views/tv_player_view.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movie_card.dart';

class SeriesGrid extends StatelessWidget {
  final String selectedCategory;

  const SeriesGrid({super.key, required this.selectedCategory});

  // Demo data with categories
  static const Map<String, List<String>> moviesByCategory = {
    'All': [
      'demo1',
      'demo2',
      'demo3',
      'demo4',
      'demo5',
      'demo6',
      'demo7',
      'demo8',
      'demo9',
      'demo10',
      'demo11',
      'demo12',
      'demo13',
      'demo14',
      'demo15',
      'demo16',
      'demo17',
      'demo18',
      'demo19',
      'demo20',
      'demo21',
      'demo22',
      'demo23',
      'demo24',
      'demo25',
      'demo26',
      'demo27',
      'demo28',
      'demo29',
      'demo30',
    ],
    'Favourite': [
      'favourite1',
      'favourite2',
      'favourite3',
      'favourite4',
      'favourite5',
      'favourite6',
      'favourite7',
      'favourite8',
    ],
    'History': [
      'history1',
      'history2',
      'history3',
      'history4',
      'history5',
      'history6',
      'history7',
      'history8',
      'history9',
      'history10',
      'history11',
      'history12',
    ],
  };

  int _calculateCrossAxisCount(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width >= 1600) return 6;
    if (width >= 1300) return 5;
    if (width >= 1000) return 4;
    if (width >= 700) return 3;
    return 3;
  }

  List<String> _getFilteredMovies() {
    return moviesByCategory[selectedCategory] ?? moviesByCategory['All']!;
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = _calculateCrossAxisCount(context);
    final List<String> filteredMovies = _getFilteredMovies();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: filteredMovies.length,
      itemBuilder: (context, index) {
        final String title = filteredMovies[index];
        return InkWell(
          onTap: () {
            g.Get.to(
              () => TvPlayerView(
                channelName: title,
                // Sample public HLS to test playback; replace with real stream per channel
                streamUrl: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
              ),
              transition: g.Transition.fade,
              duration: const Duration(milliseconds: 300),
            );
          },
          child: MovieCard(title: title, imageUrl: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQYq7Mk3_qT905pUYNwN5JfQjLJoNx6n5iqB2M9iJ5MffZmKLPklzmAUJVs7P2VgVS5gspq3Q'),
        );
      },
    );
  }
}

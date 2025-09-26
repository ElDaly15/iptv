
import 'package:flutter/material.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movie_card.dart';

class MoviesGrid extends StatelessWidget {
 MoviesGrid({super.key});

  final List<String> demoTitles = List.generate(30, (i) => 'demo${i + 1}');

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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: demoTitles.length,
      itemBuilder: (context, index) {
        final String title = demoTitles[index];
        return MovieCard(title: title);
      },
    );
  }
}

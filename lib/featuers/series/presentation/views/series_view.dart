import 'package:flutter/material.dart';
import 'package:iptv/featuers/series/presentation/views/widgets/series_view_body.dart';

class SeriesView extends StatelessWidget {
  const SeriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SeriesViewBody(),
    );
  }
}
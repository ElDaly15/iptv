import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/featuers/series/presentation/views/widgets/series_category_panel.dart';
import 'package:iptv/featuers/series/presentation/views/widgets/series_grid.dart';
import 'package:iptv/featuers/series/presentation/views/widgets/series_top_bar.dart';

class SeriesViewBody extends StatefulWidget {
  const SeriesViewBody({super.key});

  @override
  State<SeriesViewBody> createState() => _SeriesViewBodyState();
}

class _SeriesViewBodyState extends State<SeriesViewBody> {
  String selectedCategory = 'All';

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Container(
      color: AppColors.mainColorTheme,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: size.width * 0.25,
                child: SeriesCategoriesPanel(
                  selectedCategory: selectedCategory,
                  onCategorySelected: onCategorySelected,
                ),
              ),
              const SizedBox(width: 16),
              // Right side: Search + Grid
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SeriesTopBar(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SeriesGrid(selectedCategory: selectedCategory),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


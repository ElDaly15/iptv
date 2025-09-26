import 'package:flutter/material.dart';
import 'package:iptv/core/utils/app_colors.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/categories_panel.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/movies_grid.dart';
import 'package:iptv/featuers/movies/presentation/views/widgets/top_bar.dart';

class MoviesViewBody extends StatelessWidget {
  const MoviesViewBody({super.key});

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
              InkWell(onTap: (){
                Navigator.pop(context);
              }, child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
              SizedBox(width: 5,),
              SizedBox(width: size.width * 0.25, child: CategoriesPanel()),
              const SizedBox(width: 16),
              // Right side: Search + Grid
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(),
                    const SizedBox(height: 16),
                    Expanded(child: MoviesGrid()),
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


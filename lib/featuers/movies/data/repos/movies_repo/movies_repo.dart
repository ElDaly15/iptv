import 'package:dartz/dartz.dart';
import 'package:iptv/core/errors/failuer.dart';
import 'package:iptv/featuers/movies/data/models/movie_category_model.dart';

abstract class MoviesRepo {
    Future<Either<Failuer, MovieCategoriesResponse>> getMovieCategories();
}

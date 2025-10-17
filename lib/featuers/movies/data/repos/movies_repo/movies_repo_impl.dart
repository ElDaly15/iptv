import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:iptv/core/errors/exceptions.dart';
import 'package:iptv/core/errors/failuer.dart';
import 'package:iptv/core/services/api/dio_consumer.dart';
import 'package:iptv/core/services/api/endpoints.dart';
import 'package:iptv/core/services/secure_storage.dart';
import 'package:iptv/featuers/movies/data/models/movie_category_model.dart';
import 'package:iptv/featuers/movies/data/repos/movies_repo/movies_repo.dart';

class MoviesRepoImpl extends MoviesRepo {
  @override
  Future<Either<Failuer, MovieCategoriesResponse>> getMovieCategories() async {
    try {
      var playlistId = await getPlaylistId();
      var response = await DioConsumer(dio: Dio()).get(Endpoints.getMovieCategories(playlistId!));
      return Right(MovieCategoriesResponse.fromJson(response));
    } on ServerError catch (e) {
      return Left(Failuer(e.errorModel.errorMsg));
    } catch (e) {
      return Left(Failuer(e.toString()));
    }
  }
   
}
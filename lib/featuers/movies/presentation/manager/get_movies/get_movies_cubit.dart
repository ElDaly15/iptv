import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:iptv/featuers/movies/data/models/movie_model.dart';
import 'package:iptv/featuers/movies/data/repos/movies_repo/movies_repo_impl.dart';

part 'get_movies_state.dart';

class GetMoviesCubit extends Cubit<GetMoviesState> {
  GetMoviesCubit() : super(GetMoviesInitial());
  void getMovies(String categoryId) async {
    emit(GetMoviesLoading());
    var response = await MoviesRepoImpl().getMovieItems(categoryId);
    response.fold((l) => emit(GetMoviesError(l.message)), (r) => emit(GetMoviesSuccess(r)));
  }
}

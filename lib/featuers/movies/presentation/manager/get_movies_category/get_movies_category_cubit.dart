import 'package:bloc/bloc.dart';
import 'package:iptv/featuers/movies/data/models/movie_category_model.dart';
import 'package:iptv/featuers/movies/data/repos/movies_repo/movies_repo_impl.dart';
import 'package:meta/meta.dart';

part 'get_movies_category_state.dart';

class GetMoviesCategoryCubit extends Cubit<GetMoviesCategoryState> {
  GetMoviesCategoryCubit() : super(GetMoviesCategoryInitial());
  void getMoviesCategory() async {
    emit(GetMoviesCategoryLoading());
    var response = await MoviesRepoImpl().getMovieCategories();
    response.fold((l) => emit(GetMoviesCategoryError(l.message)), (r) => emit(GetMoviesCategorySuccess(r)));
  }
}

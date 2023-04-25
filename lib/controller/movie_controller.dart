import 'package:get/state_manager.dart';
import 'package:movie/models/movie_ob.dart';
import 'package:movie/models/response_ob.dart';
import 'package:movie/network/base_network.dart';

import '../utils/app_constants.dart';

class MovieController extends GetxController {
  var isLoadingList = true.obs;
  var isLoadingDetail = true.obs;

  var isError = false.obs;

  var movieList = <MovieOb>[].obs;
  var movie = MovieOb().obs;

  @override
  void onInit() {
    fetchMovieList();
    super.onInit();
  }

  void fetchMovieList() async {
    try {
      isLoadingList(true);
      var responseOb = await BaseNetwork().getRequest(url: getList);
      if (responseOb != null) {
        if(responseOb.responseState == ResponseState.data) {
          movieList.value = movieFromJson(responseOb.data);
          isError(false);
        } else {
          isError(true);
        }
      }
      else{
        isError(true);
      }
    } finally {
      isLoadingList(false);
    }
  }

  void fetchMovieDetail(String id) async {
    try {
      isLoadingDetail(true);
      var responseOb = await BaseNetwork().getRequest(url: detail + id);
      if (responseOb != null) {
        if(responseOb.responseState == ResponseState.data){
          movie.value = movieDetailFromJson(responseOb.data);
          isError(false);
        }
        else{
          isError(true);
        }
      } else{
        isError(true);
      }
    } finally {
      isLoadingDetail(false);
    }
  }
}
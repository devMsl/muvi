import 'dart:convert';

import 'package:movie/models/movie_ob.dart';
import 'package:movie/utils/app_constants.dart';
import 'package:rxdart/rxdart.dart';

import '../models/response_ob.dart';
import '../network/base_network.dart';

class MovieBloc extends BaseNetwork {
  String? endUrl;
  ObType? obType;
  MovieBloc(this.endUrl, this.obType);
  PublishSubject<ResponseOb> controller = PublishSubject();
  Stream<ResponseOb> movieStream() => controller.stream;

  getMovieData() {
    ResponseOb responseOb = ResponseOb(responseState: ResponseState.loading, data: null);
    controller.sink.add(responseOb);
    getRequest(url: endUrl ?? '').then((rv) {

      if (rv.responseState == ResponseState.data) {
        dynamic ob;
        switch(obType){
          case ObType.list: {
            Iterable l = json.decode(rv.data);
            List<MovieOb> movieList = List<MovieOb>.from(l.map((model)=> MovieOb.fromJson(model)));
            ob = movieList;
            responseOb.responseState = ResponseState.data;
            responseOb.data = ob;
            controller.sink.add(responseOb);

          } break;
          case ObType.detail:
            {
              ob = MovieOb.fromJson(json.decode(rv.data));
              responseOb.responseState = ResponseState.data;
              responseOb.data = ob;
              controller.sink.add(responseOb);

            }
            break;
          default : null; break;
        }

      } else {
        responseOb.responseState = ResponseState.error;
        responseOb.data = rv.data;
        controller.sink.add(responseOb);
      }
    }).catchError((err) {
      responseOb.responseState = ResponseState.error;
      responseOb.data = err.toString();
      controller.sink.add(responseOb);
    });
  }

  void dispose() {
    controller.close();
  }
}

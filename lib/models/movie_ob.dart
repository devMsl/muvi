import 'dart:convert';

List<MovieOb> movieFromJson(String str) =>
    List<MovieOb>.from(json.decode(str).map((x) => MovieOb.fromJson(x)));

MovieOb movieDetailFromJson(String str) =>
    MovieOb.fromJson(json.decode(str));


class MovieOb{
  int? iD;
  String? title;
  String? synopsis;
  String? runTime;
  String? director;
  String? cast;
  String? production;
  String? distribution;
  String? type;
  String? coverImageUrl;
  String? trailer;
  List<String>? imageUrls;
  String? accesstime;
  String? releaseDate;
  String? uniqueID;

  MovieOb(
      {this.iD,
        this.title,
        this.synopsis,
        this.runTime,
        this.director,
        this.cast,
        this.production,
        this.distribution,
        this.type,
        this.coverImageUrl,
        this.trailer,
        this.imageUrls,
        this.accesstime,
        this.releaseDate,
        this.uniqueID});

  MovieOb.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    synopsis = json['Synopsis'];
    runTime = json['RunTime'];
    director = json['Director'];
    cast = json['Cast'];
    production = json['Production'];
    distribution = json['Distribution'];
    type = json['Type'];
    coverImageUrl = json['CoverImageUrl'];
    trailer = json['Trailer'];
    imageUrls = json['ImageUrls'].cast<String>();
    accesstime = json['Accesstime'];
    releaseDate = json['ReleaseDate'];
    uniqueID = json['UniqueID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['ID'] = iD;
    data['Title'] = title;
    data['Synopsis'] = synopsis;
    data['RunTime'] = runTime;
    data['Director'] = director;
    data['Cast'] = cast;
    data['Production'] = production;
    data['Distribution'] = distribution;
    data['Type'] = type;
    data['CoverImageUrl'] = coverImageUrl;
    data['Trailer'] = trailer;
    data['ImageUrls'] = imageUrls;
    data['Accesstime'] = accesstime;
    data['ReleaseDate'] = releaseDate;
    data['UniqueID'] = uniqueID;
    return data;
  }
}

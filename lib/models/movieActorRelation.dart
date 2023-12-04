import 'dart:convert';

class MovieActorRelation {
  int id;
  String title;
  String posterPath;
  String releaseDate;

  MovieActorRelation({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
  });

  factory MovieActorRelation.fromMap(Map<String, dynamic> map) {
    return MovieActorRelation(
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
    );
  }

  factory MovieActorRelation.fromJson(String source) => MovieActorRelation.fromMap(json.decode(source));

  String getFoto() =>
      posterPath == null
          ? 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg'
          : 'https://image.tmdb.org/t/p/w500/$posterPath';

}
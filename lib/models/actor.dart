import 'dart:convert';

class Actor 
{
  int id;
  String name;
  String profilePath;
  String biography;
  String birthday;
  double popularity;
  //List<int> moviesIds;
  Actor
  ({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.biography,
    required this.birthday,
    required this.popularity,
    //required this.moviesIds,
  });

  factory Actor.fromMap(Map<String, dynamic> map) 
  {
    return Actor
    (
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      biography: map['biography'] ?? '',
      birthday: map['birthday'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      //moviesIds: List<int>.from(map['genre_ids']),
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}

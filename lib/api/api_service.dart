import 'dart:convert';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/movieActorRelation.dart';
import 'package:movies_app/models/biography.dart';
import 'package:movies_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/review.dart';

class ApiService {
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getTrending() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}trending/person/day?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getPopular() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?include_adult=false&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  static Future<List<MovieActorRelation>> getActorMovie(String actorName) async {
  List<MovieActorRelation> cast = [];
  try {
    http.Response response = await http.get(Uri.parse(
        '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));

    var castData = jsonDecode(response.body)['results'];

    // Find the actor by name (case-insensitive comparison)
    var actor = castData.firstWhere(
      (personData) => personData['name'].toString().toLowerCase().contains(actorName.toLowerCase()),
      orElse: () => null,
    );

    if (actor != null) {
      var knownFor = actor['known_for'] as List<dynamic>;

      // Loop through known_for array and add ActorMovie instances
      for (var movieData in knownFor) {
        if (movieData['media_type'] == 'movie') {
          cast.add(
            MovieActorRelation(
              id: movieData['id'] as int,
              title: movieData['title'] ?? '',
              posterPath: movieData['poster_path'] ?? '',
              releaseDate: movieData['release_date'] ?? '',
            ),
          );
        }
      }
    }

    return cast;
  } catch (e) {
    return [];
  }
}

 static Future<ActorBiography?> getBiography(int actorId) async {
    try {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/$actorId?api_key=${Api.apiKey}&language=en-US&page=1'));
    var res = jsonDecode(response.body);

      return ActorBiography(
        id: res['id'],
        biography: res['biography'],
      );

  } catch (e) {
    return null;
  }

  }

  static Future<List<Movie>?> getSearchedActors(String query) async 
  {
    List<Movie> actors = [];
    try 
    {
      http.Response response = await http.get(Uri.parse('${Api.baseUrl}/3/search/person?api_key=${Api.apiKey}&query=$query'));
      var res = jsonDecode(response.body);
      res['results'].forEach
      (
        (m) => actors.add
        (
          Movie.fromMap(m),
        ),
      );
      return actors;
    } 
    catch (e) 
    {
      return null;
    }
  }

  
}

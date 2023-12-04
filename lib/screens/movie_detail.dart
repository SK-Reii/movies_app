import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/controllers/movies_controller.dart';
import 'package:movies_app/models/biography.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movieActorRelation.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieActorRelation movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.getFoto(),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              'Título: ${movie.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha de lanzamiento: ${movie.releaseDate}',
              style: const TextStyle(fontSize: 16),
            ),
            // Otros detalles de la película
          ],
        ),
      ),
    );
  }
}

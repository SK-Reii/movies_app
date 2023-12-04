import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/controllers/movies_controller.dart';
import 'package:movies_app/models/biography.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movieActorRelation.dart';
import 'package:movies_app/screens/movie_detail.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.actor,
  }) : super(key: key);

  final Movie actor;

  @override
  Widget build(BuildContext context) {
    ApiService.getMovieReviews(actor.id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    Api.imageBaseUrl + actor.profilePath,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: IconButton(
                      tooltip: 'Volver al inicio',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actor.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset('assets/Star.svg'),
                        const SizedBox(width: 5),
                        Text(
                          actor.popularity == 0.0
                              ? 'N/A'
                              : actor.popularity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFF8700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder<ActorBiography?>(
                      future: ApiService.getBiography(actor.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error cargando la biografía: ${snapshot.error}',
                            textAlign: TextAlign.start,
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data != null) {
                          ActorBiography bio = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: Text(
                              bio.biography,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        } else {
                          return const Text(
                            'No hay una biografía disponible.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Películas de ${actor.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder<List<MovieActorRelation>?>(
                      future: ApiService.getActorMovie(actor.name),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.start,
                          );
                        } else if (snapshot.hasData) {
                          List<MovieActorRelation> cast = snapshot.data!;
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: cast.map((movie) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => MovieDetailsScreen(movie: movie));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        movie.getFoto(),
                                        height: 150,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      movie.title,
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      movie.releaseDate,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Text(
                            'No hay información de películas disponibles.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Tooltip(
                      message: 'Guardar este actor en tu lista de favoritos',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchList(actor);
                        },
                        icon: Obx(() => Get.find<MoviesController>().isInWatchList(actor)
                            ? const Icon(
                                Icons.bookmark,
                                color: Colors.white,
                                size: 33,
                              )
                            : const Icon(
                                Icons.bookmark_outline,
                                color: Colors.white,
                                size: 33,
                              )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

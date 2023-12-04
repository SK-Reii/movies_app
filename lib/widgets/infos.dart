import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/models/movie.dart';

class Infos extends StatelessWidget {
  final Movie actorMovie;

  const Infos({Key? key, required this.actorMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              actorMovie.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset('assets/Star.svg'),
              const SizedBox(width: 5),
              Text(
                actorMovie.popularity == 0.0 ? 'N/A' : actorMovie.popularity.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Color(0xFFFF8700),
                ),
              ),
            ],
          ),
          // Otros detalles del actor aquí (géneros, fecha de lanzamiento, etc.)
        ],
      ),
    );
  }
}

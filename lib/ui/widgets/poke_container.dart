import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/utils/text_capitalization.dart';

class PokeContainer extends StatelessWidget {
  const PokeContainer(this.pokemon, {super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/details', arguments: pokemon),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 150,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: pokemon.id,
                    child: SvgPicture.network(
                        pokemon.image!,
                        width: 80,
                        height: 80,
                      ),
                  ),
                  const SizedBox(height: 10),
                  Text(Capitalization.capitalize(pokemon.name)),
                ],
              ),
              Transform.translate(
                offset: const Offset(-61, -58),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                  ),
                  child: Center(
                    child: Text(
                      pokemon.id.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/providers/pokemon_provider.dart';
import 'package:pokedex/app/utils/text_capitalization.dart';
import 'package:pokedex/ui/widgets/type_container.dart';
import 'package:provider/provider.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30))
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const BackButton(
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          const Text("Pokedex", style: TextStyle(color: Colors.white, fontSize: 22)),
                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Text('#${pokemon.id}', style: const TextStyle(color: Colors.white, fontSize: 22)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Hero(
                        tag: pokemon.id,
                        child: SvgPicture.network(
                          pokemon.image!,
                          width: 150,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(Capitalization.capitalize(pokemon.name), style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: FutureBuilder(
                    future: pokemonProvider.getPokemonDetails(pokemon),
                    builder: (BuildContext context, AsyncSnapshot<Pokemon?> snapshot) {

                      if(!snapshot.hasData){
                        return const Padding(
                          padding: EdgeInsets.only(top: 70.0),
                          child: SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(color: Colors.redAccent)
                          )
                        );

                      } else if(snapshot.data == null) {
                          return Container();

                      } else {

                        final Pokemon data = snapshot.data as Pokemon;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            data.description != null  ? Center(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(data.description!),
                            )) : const SizedBox(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: data.types!.map<Widget>((element) => TypeContainer(element.type.name)).toList()
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(data.weight.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    const Text("Weight", style: TextStyle(fontSize: 16, color: Colors.blueGrey))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(data.weight.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    const Text("Weight", style: TextStyle(fontSize: 16, color: Colors.blueGrey))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 32),
                            const Center(child: Text("PokeData", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                            const SizedBox(height: 15),
                            Column(
                              children: data.stats!.map<Widget>((element) => ProgressIndicator(name: element.stat.name, baseStarts: element.baseStat)).toList(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }
                    }
                ),
              )
            ],
          ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  ProgressIndicator({
    required this.name,
    super.key,
    required this.baseStarts
  }) {
   if(baseStarts > 100) baseStarts = 100;
  }

  final String name;
  int baseStarts;

  static const Map<String, Color> indicatorColor = {
    "hp" : Colors.green,
    "attack" : Colors.red,
    "defense" : Colors.blue,
    "special-attack" : Colors.deepPurple,
    "special-defense" : Colors.teal,
    "speed" : Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 2),
          child: Text(Capitalization.capitalize(name), style: const TextStyle(fontSize: 15)),
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 1,
          animation: true,
          lineHeight: 25.0,
          animationDuration: 1000,
          percent: baseStarts * 0.01,
          center: Text("$baseStarts%", style: const TextStyle(color: Colors.white),),
          progressColor: indicatorColor[name],
          barRadius: const Radius.circular(20),
        ),
        const SizedBox(height: 12)
      ],
    );
  }
}


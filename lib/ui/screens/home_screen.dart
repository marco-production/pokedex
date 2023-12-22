import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/providers/pokemon_provider.dart';
import 'package:pokedex/ui/widgets/poke_container.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int offset = 0;
    final PokemonProvider pokemonProvider = Provider.of<PokemonProvider>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Pokedex', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        //titleSpacing: 20,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: FutureBuilder(
                future: pokemonProvider.getPokemons(offset),
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if(snapshot.hasData) {

                    List<Pokemon> pokemons = snapshot.data as List<Pokemon>;

                    return Wrap(
                      alignment: WrapAlignment.start,
                      children: pokemons.map<Widget>((pokemon) => PokeContainer(pokemon)
                      ).toList()
                    );
                  }
                  else {
                    return Container();
                  }
                }
              ),
            ),
          ),
        ),
      )
    );
  }
}

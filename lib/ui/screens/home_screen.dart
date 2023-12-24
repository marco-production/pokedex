import 'dart:async';

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

  bool isLoading = false;
  int offset = 0;
  late final ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _loadPokemons();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final PokemonProvider pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Pokedex',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        //titleSpacing: 20,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Stack(
              children: [
                Center(
                  child: FutureBuilder(
                      future: pokemonProvider.getPokemons(offset),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Pokemon>> snapshot) {
                        if (snapshot.hasData) {
                          return Wrap(
                              alignment: WrapAlignment.start,
                              children: snapshot.data!
                                  .map<Widget>((pokemon) => PokeContainer(pokemon))
                                  .toList());
                        } else {
                          return Container();
                        }
                      }),
                ),
                isLoading ? SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 5.0,)),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadPokemons() async {
    setState(() {
      isLoading = true;
      offset = offset + 10;
    });

    Timer(const Duration(milliseconds: 500), () {
      setState(() => isLoading = false);

      scrollController.animateTo(
          scrollController.position.pixels + 200,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn
      );
    });
  }
}

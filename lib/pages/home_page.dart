import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/pages/home_page/widgets/app_bar_home.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeAPIStore;
  @override
  void initState() {
    super.initState();
    pokeAPIStore = PokeApiStore();
    pokeAPIStore.fetchPokemonList();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusTop = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(screenWidth / 6.5),
            left: (screenWidth / 1.6),
            child: Opacity(
              child: Image.asset(
                ConstsApp.blackPokeball,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusTop,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Container(
                      child: Observer(
                        builder: (context) {
                          PokeAPI _pokeApi = pokeAPIStore.pokeAPI;
                          return (_pokeApi != null)
                              ? ListView.builder(
                                itemCount: _pokeApi.pokemon.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(title: Text(_pokeApi.pokemon[index].name),);
                                  },
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:clone_yt/CustomSearchDelegate.dart';
import 'package:clone_yt/telas/Biblioteca.dart';
import 'package:clone_yt/telas/EmAlta.dart';
import 'package:clone_yt/telas/Inicio.dart';
import 'package:clone_yt/telas/Inscricoes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String _resultado = "";
  int _indiceAtual = 0;


  @override
  Widget build(BuildContext context) {

    List<Widget>telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricoes(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2),
            )],
          ),
          child: AppBar(
            title: Image.asset("images/youtube.png", width: 98, height: 22,),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  String? res = await showSearch(context: context, delegate: CustomSearchDelegate(busca: _resultado));
                  setState(() {
                    _resultado = res.toString();
                    print("resultado: " +_resultado);
                  });
                },
              ),
            ],
            elevation: 0, // Remova a sombra padrão do AppBar
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            label: "Início",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: "Em alta",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: "Inscrições",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Biblioteca",
          ),
        ],
      ),
    );
  }
}

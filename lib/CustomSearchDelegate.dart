import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String>{
  String? busca = "";


  CustomSearchDelegate({this.busca}){
    print("busca é: " + busca.toString());

    query = busca!;
    print("query é: " + query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, query);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> lista =  [];

    if(query.isNotEmpty){
      lista = [
        "Android", "Android navegação", "IOS", "Jogos", "Flutter", "React"
      ].where((texto) => texto.toLowerCase().startsWith(query.toLowerCase())).toList();

      return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              close(context, lista[index]);
            },
            title: Text(lista[index]),
          );
        },
      );
    }
    else{
      return Center(
        child: Text(""),
      );
    }
  }
}
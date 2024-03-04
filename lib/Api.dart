import 'package:clone_yt/model/Video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const CHAVE_YT_API = 'AIzaSyAW9ZhWNwm7F3IKBi5OxwRQLdXfgFZm0Y4';
const URL_BASE = 'https://www.googleapis.com/youtube/v3/';

class Api{
  pesquisar(String pesquisa) async {
    http.Response response = await http.get(
      Uri.parse(
        URL_BASE + 'search'
        '?part=snippet'
        '&type=video'
        '&maxResults=20'
        '&order=date'
        '&key=$CHAVE_YT_API'
        '&q=$pesquisa'
      )
    );
    if (response.statusCode == 200){

      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<Video> videos = dadosJson['items'].map<Video>(
        (map){
          return Video.fromJson(map);
        }
      ).toList();
      return dadosJson;
    } else {
      print('Erro ao pesquisar dados');
    }
  }
}
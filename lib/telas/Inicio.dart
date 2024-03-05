import 'package:clone_yt/Api.dart';
import 'package:clone_yt/model/Video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {

  String pesquisa;
  Inicio(this.pesquisa);


  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String p){
    Api api = Api();
    return api.pesquisar(p);
  }
  _playVideo(String id){
    print("id do video: " + id);

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.pesquisa),
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData){
                return ListView.separated(
                    itemBuilder: (context, index){
                      List<Video>? videos = snapshot.data;
                      Video? video = videos?[index];
                      return GestureDetector(
                        onTap: _playVideo(video!.id.toString()),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(video!.thumbnail.toString()),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(video.title.toString()),
                              subtitle: Text(video.canal.toString()),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      height: 3,
                      color: Colors.grey,
                    ),
                    itemCount: snapshot.data!.length
                );
              } else {
                return Center(
                  child: Text("Nenhum dado a ser exibido"),
                );
              }
              break;
          }
        }
    );
  }
}

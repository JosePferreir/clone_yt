class Video{
  String? id;
  String? title;
  String? thumbnail;
  String? url;
  String? canal;
  String? description;

  Video({this.id, this.title, this.thumbnail, this.url, this.canal, this.description});

  factory Video.fromJson(Map<String,dynamic> json){
    return Video(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        description: json['snippet']['description'],
        thumbnail: json['snippet']['thumbnails']['high']['url'],
        canal: json['snippet']['channelTitle'],
    );

  }
}
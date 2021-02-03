class WallpaperModel{
  SrcModel src;
  WallpaperModel({this.src});

  factory WallpaperModel.fromMap(Map<String,dynamic>jsonData){
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),

    );
  }

}

class SrcModel{
  String original;
  String small;
  String portrait;

  SrcModel ({this.original, this.small, this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic>jsonData){
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"],
    );
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallio/model/wallpaper_model.dart';
import 'package:wallio/screens/image.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget appName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Wallio"),
    ],
  );
  /*return RichText(
  text: TextSpan(
    text: 'Wall',
    style: TextStyle(fontSize:20, fontWeight: FontWeight.w700,color: Colors.black),
    children: <TextSpan>[
      TextSpan(text: 'io', style: TextStyle(color: Colors.black,fontSize: 18)),
    ],
  ),
);*/
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    /*decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),*/
    padding: EdgeInsets.symmetric(horizontal: 12),
    //padding: EdgeInsets.only(top:20, left: 12, right: 12),
    child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        childAspectRatio: 0.6,
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImagaView(
                            imgUrl: wallpaper.src.original,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: kIsWeb
                        ? Image.network(
                            wallpaper.src.portrait,
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: wallpaper.src.portrait,
                            placeholder: (context, url) => Container(
                                  color: Color(0xfff5f8fd),
                                ),
                            fit: BoxFit.cover)),
              ),
            ),
          ));
        }).toList()),
  );
}

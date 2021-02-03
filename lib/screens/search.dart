import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallio/data/data.dart';
import 'package:wallio/model/wallpaper_model.dart';
import 'package:wallio/widgets/widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Search extends StatefulWidget {
  final String searchValue;
  Search({this.searchValue});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();
  var isLoading = false;

  getSearch(String query) async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=30",
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSearch(widget.searchValue);
    searchController.text = widget.searchValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.searchValue),
        elevation: 0.0,
      ),
      body: isLoading
          ? Center(
              child: SpinKitFadingCube(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    /* Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0,2),
                  ),],
                ),
                padding: EdgeInsets.symmetric(horizontal:12),
                margin: EdgeInsets.only(left:24, right: 24, top: 10),
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "pesquisar...",
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      getSearch(searchController.text);
                    },
                    child: Container(
                      child: Icon(Icons.search)))
                ],),
              ),*/
                    SizedBox(
                      height: 10,
                    ),
                    wallpapersList(wallpapers: wallpapers, context: context),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Photos provided by',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: ' Pexels',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallio/data/data.dart';
import 'package:wallio/model/categories_model.dart';
import 'package:wallio/model/wallpaper_model.dart';
import 'package:wallio/screens/categories.dart';
import 'package:wallio/screens/search.dart';
import 'package:wallio/widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();
  var isLoading = false;

  getTrending() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=50",
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

  getPermissions() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    getTrending();
    categories = getCategories();
    getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appName(),
        elevation: 0.0,
      ),
      body: isLoading
          ? Center(
              child: SpinKitFadingCube(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        margin: EdgeInsets.only(left: 24, right: 24, top: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                onSubmitted: (term) {
                                  if (searchController.text.isEmpty) {
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Search(
                                            searchValue: searchController.text,
                                          ),
                                        ));
                                  }
                                },
                                controller: searchController,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  hintText: "pesquisar...",
                                  border: InputBorder.none,
                                  /*suffixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                color: Colors.black,
                                iconSize: 18,
                                onPressed: () => searchController.clear()),*/
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  if (searchController.text.isEmpty) {
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Search(
                                            searchValue: searchController.text,
                                          ),
                                        ));
                                  }
                                },
                                child: Container(child: Icon(Icons.search)))
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.only(top: 18, bottom: 4),
                              child: Text('Categorias',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15))),
                        ],
                      ),
                      Container(
                        height: 72,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: 15),
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoriesTile(
                                title: categories[index].displayName,
                                imgUrl: categories[index].imgUrl,
                                name: categories[index].categorieName,
                              );
                            }),
                      ),
                      //SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.only(top: 10, bottom: 5),
                              child: Text('Trending',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20))),
                        ],
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
            ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title, name;
  CategoriesTile({@required this.title, @required this.imgUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Categorie(
                categorieName: this.name,
                displayName: this.title,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: kIsWeb
                          ? Image.network(
                              imgUrl,
                              height: 72,
                              width: 112,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrl,
                              height: 72,
                              width: 112,
                              fit: BoxFit.cover,
                            )),
                  Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.black12,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: kIsWeb
                          ? Image.network(
                              imgUrl,
                              height: 72,
                              width: 112,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrl,
                              height: 72,
                              width: 112,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 72,
                    width: 112,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                      height: 72,
                      width: 112,
                      alignment: Alignment.center,
                      child: Text(
                        title ?? "Erro",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}

import 'package:wallio/model/categories_model.dart';

String apiKey = "563492ad6f917000010000015e75752068b949dbad5bb9f4ed412bd1";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = new List();
  CategoriesModel categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://i.pinimg.com/564x/91/f6/6d/91f66dfc38b4247d966bf2efaaa0c85d.jpg";
  categoriesModel.categorieName = "iphone wallpaper";
  categoriesModel.displayName = "Curated";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categorieName = "Street Art";
  categoriesModel.displayName = "Street Art";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categorieName = "Wild Life";
  categoriesModel.displayName = "Wild Life";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categorieName = "Nature";
  categoriesModel.displayName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categorieName = "City";
  categoriesModel.displayName = "City";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoriesModel.categorieName = "Motivation";
  categoriesModel.displayName = "Motivation";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categorieName = "Bikes";
  categoriesModel.displayName = "Bikes";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoriesModel.categorieName = "Cars";
  categoriesModel.displayName = "Cars";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  return categories;
}

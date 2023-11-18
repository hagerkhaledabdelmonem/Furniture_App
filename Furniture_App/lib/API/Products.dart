class Products {
  final String title;
   String? brand;
   double? rating;
   int? reviews;
  final double price;
   double? price_was;
   double? percentage_off;
  bool is_favorited = false;
  List images;

  Products({required this.title,required this.price,required this.rating,
    required this.percentage_off,required this.brand,required this.reviews,required this.price_was,required this.is_favorited,required this.images});

  static List<Products> convertToProducts(List products) {
    List<Products> productsList = [];
    for (var product in products) {
      if(product["title"]==null||product["price"]==null || product["thumbnails"] == null){
        continue;
      }
      productsList.add(Products(
        title: product["title"],
        price: product["price"],
        rating: product["rating"],
        brand: product["brand"],
        reviews: product["reviews"],
        price_was: product["price_was"],
        percentage_off: product["percentage_off"],
        is_favorited: false,
        images: product["thumbnails"]
      ));
    }
    return productsList;
  }


}
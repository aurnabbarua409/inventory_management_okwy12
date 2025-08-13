class UpdateProductModel {
  String product;
  int price;
  bool availability;

  UpdateProductModel(
      {required this.product, required this.availability, required this.price});

  Map<String, dynamic> toJson() {
    return {"product": product, "price": price, "availability": availability};
  }
}

class UpdateProductModel2 {
  String product;
  int price;
  bool availability;

  UpdateProductModel2(
      {required this.product, required this.availability, required this.price});

  Map<String, dynamic> toJson() {
    return {"_id": product, "price": price, "availability": availability};
  }
}

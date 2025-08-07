class SendProductModel {
  final List<String> product;
  final List<String> wholesaler;

  SendProductModel(this.product, this.wholesaler);

  Map<String, dynamic> toJson() =>
      {"product": product, "wholesaler": wholesaler};
}

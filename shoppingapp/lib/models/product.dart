class Product {
  int? id;
  String? name;
  String? image;
  int? price;
  int? priceSaleOff;
  int? rating;
  bool? special;
  String? summary;
  String? description;
  bool? isNew;
  int? categoryId;

  Product(
      {this.id,
        this.name,
        this.image,
        this.price,
        this.priceSaleOff,
        this.rating,
        this.special,
        this.summary,
        this.description,
        this.isNew,
        this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    priceSaleOff = json['price_sale_off'];
    rating = json['rating'];
    special = json['special'];
    summary = json['summary'];
    description = json['description'];
    isNew = json['is_new'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['price_sale_off'] = this.priceSaleOff;
    data['rating'] = this.rating;
    data['special'] = this.special;
    data['summary'] = this.summary;
    data['description'] = this.description;
    data['is_new'] = this.isNew;
    data['category_id'] = this.categoryId;
    return data;
  }
}
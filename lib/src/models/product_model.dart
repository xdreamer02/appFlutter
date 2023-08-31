import 'package:planck/constants/constants.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
    required this.image,
    this.number = 1,
    this.note = '',
  });

  int id;
  int companyId;
  String name;
  String description;
  int type;
  double price;
  String image;

  bool isInCart = false;

  int number;
  String note;
  String companyName;

  double get total => price * number;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        companyId: json["companyId"],
        companyName: json["companyName"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        price: json["price"].toDouble(),
        image: json["image"],
        number: json["number"] ?? 1,
        note: json["note"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "number": number,
        "total": double.parse(total.toStringAsFixed(kCoinDecimals)),
        "note": note,
      };
}

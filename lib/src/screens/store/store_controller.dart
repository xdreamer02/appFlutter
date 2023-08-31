import 'package:flutter/material.dart';
import 'package:planck/src/models/address_model.dart';
import 'package:planck/src/models/company_model.dart';
import 'package:planck/src/models/fee_model.dart';
import 'package:planck/src/models/product_model.dart';
import 'package:planck/src/provider/db_provider.dart';
import 'package:planck/src/services/market_service.dart';

class StoreController with ChangeNotifier {
  final MarketService marketService = MarketService();

  late CompanyModel _company;
  bool _inAsyncCall = false;
  double _deliveryFee = 0.0;
  final List<ProductModel> _products = [];

  CompanyModel get company => _company;

  set company(CompanyModel company) {
    _company = company;
    loadProducts();
    loadDeliveryFeed();
  }

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  double get deliveryFee => _deliveryFee;

  set deliveryFee(double cost) {
    _deliveryFee = cost;
    notifyListeners();
  }

  List<ProductModel> get products => _products;

  setProducts(ProductModel product) {
    final index = _products.indexWhere((pr) => pr.id == product.id);
    if (index < 0) return;
    _products[index] = product;
    notifyListeners();
  }

  loadDeliveryFeed() async {
    AddressModel? address = await DBProvider.db.loadAddress();
    if (address == null) {
      return;
    }
    List<FeeModel> fees = await marketService.deliveryCost(
        company.id.toString(), address.location.x, address.location.y);
    int index = fees.indexWhere((fee) => fee.storeId == company.storeId);
    if (index < 0) return;
    deliveryFee = fees[index].deliveryfee;
  }

  loadProducts() async {
    products.clear();
    inAsyncCall = true;
    List<ProductModel> productsResponse =
        await marketService.getProducts(company.id);
    final List<ProductModel> productsCart = await DBProvider.db.loadProducts();
    for (var product in productsResponse) {
      int index = productsCart
          .indexWhere((productCart) => productCart.id == product.id);
      if (index >= 0) {
        product.isInCart = true;
      }
      products.add(product);
    }
    inAsyncCall = false;
    notifyListeners();
  }
}

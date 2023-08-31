import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:planck/constants/constants.dart';
import 'package:planck/src/models/address_model.dart';
import 'package:planck/src/models/cart_summary_model.dart';
import 'package:planck/src/models/category_model.dart';
import 'package:planck/src/models/company_model.dart';
import 'package:planck/src/models/fee_model.dart';
import 'package:planck/src/models/market_companies_response.dart';
import 'package:planck/src/models/order_model.dart';
import 'package:planck/src/models/product_model.dart';
import 'package:planck/src/provider/preferences_provider.dart';

const _urlCompanies = 'client/market/companies';
const _urlCategories = 'client/market/categories';
const _urlProducts = 'client/market/products/company';
const _urlOrders = 'client/market/orders';
const _urlOrder = 'client/market/order/';
const _urlDeliveryCost = 'client/market/delivery-cost/companies';
const _urlBuy = 'client/market/buy';
const _urlQualify = 'client/market/qualify';

class MarketService {
  final prefs = PreferencesProvider();

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> orders = [];
    var client = http.Client();
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlOrders'),
        headers: {
          'Authorization': 'Bearer ${prefs.token}',
        },
      );
      if (resp.statusCode != 200) return orders;
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['orders']) {
        orders.add(OrderModel.fromJson(item));
      }
    } catch (err) {
      if (kDebugMode) {
        print('MarketService getOrders: $err');
      }
    } finally {
      client.close();
    }
    return orders;
  }

  Future<OrderModel> getOrder(OrderModel order) async {
    var client = http.Client();
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlOrder${order.id}'),
        headers: {'Authorization': 'Bearer ${prefs.token}'},
      );
      if (resp.statusCode != 200) return order;
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      return OrderModel.fromJson(decodedResp['order']);
    } catch (err) {
      if (kDebugMode) {
        print('MarketService getOrders: $err');
      }
    } finally {
      client.close();
    }
    return order;
  }

  // companyIds example 1,2,3
  Future<List<FeeModel>> deliveryCost(
      String companyIds, double lt, double lg) async {
    List<FeeModel> fees = [];
    var client = http.Client();
    try {
      final resp = await client.get(
        Uri.parse(
            '$kDomain$_urlDeliveryCost/$companyIds?longitude=$lg&latitude=$lt'),
        headers: {'Authorization': 'Bearer ${prefs.token}'},
      );
      if (resp.statusCode != 200) return fees;
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['fees']) {
        fees.add(FeeModel.fromJson(item));
      }
    } catch (err) {
      if (kDebugMode) {
        print('MarketService deliveryCost: $err');
      }
    } finally {
      client.close();
    }
    return fees;
  }

  Future<MarketCompaniesResponse> getCompanies(
      CategoryModel selectedCategory, double lt, double lg) async {
    List<ProductModel> products = [];
    List<CompanyModel> companies = [];

    final String param =
        selectedCategory.id > 0 ? '&categoryId=${selectedCategory.id}' : '';
    var client = http.Client();
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlCompanies?longitude=$lg&latitude=$lt$param'),
      );
      if (resp.statusCode != 200) {
        return MarketCompaniesResponse(
            companies: companies, products: products);
      }
      Map<String, dynamic> decodedResp = json.decode(resp.body);

      for (var item in decodedResp['companies']) {
        companies.add(CompanyModel.fromJson(item));
      }

      for (var item in decodedResp['products']) {
        products.add(ProductModel.fromJson(item));
      }

      return MarketCompaniesResponse(companies: companies, products: products);
    } catch (err) {
      if (kDebugMode) {
        print('MarketService getCompanies: $err');
      }
    } finally {
      client.close();
    }
    return MarketCompaniesResponse(companies: companies, products: products);
  }

  Future<List<CategoryModel>> getCategories(double lt, double lg) async {
    List<CategoryModel> categories = [];
    var client = http.Client();
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlCategories?longitude=$lg&latitude=$lt'),
      );
      if (resp.statusCode != 200) return categories;
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      for (var item in decodedResp['categories']) {
        categories.add(CategoryModel.fromJson(item));
      }
    } catch (err) {
      if (kDebugMode) {
        print('MarketService getCategories: $err');
      }
    } finally {
      client.close();
    }
    return categories;
  }

  Future<List<ProductModel>> getProducts(int companyId) async {
    List<ProductModel> products = [];
    var client = http.Client();
    try {
      final resp = await client.get(
        Uri.parse('$kDomain$_urlProducts/$companyId'),
      );
      if (resp.statusCode != 200) return products;
      Map<String, dynamic> decodedResp = json.decode(resp.body);

      for (var item in decodedResp['products']) {
        products.add(ProductModel.fromJson(item));
      }
    } catch (err) {
      if (kDebugMode) {
        print('MarketService getProducts: $err');
      }
    } finally {
      client.close();
    }
    return products;
  }

  Future<OrderModel?> buy(
      CartSummaryModel cartSummary, AddressModel address, int payment) async {
    OrderModel? orderModel;
    var client = http.Client();
    try {
      final resp = await client.post(Uri.parse('$kDomain$_urlBuy'),
          headers: {
            'Authorization': 'Bearer ${prefs.token}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: cartSummary.toHttpBodyBuy(address, payment));
      if (resp.statusCode != 200) return orderModel;
      Map<String, dynamic> decodedResp = json.decode(resp.body);
      orderModel = OrderModel.fromJson(decodedResp['order']);
    } catch (err) {
      if (kDebugMode) {
        print('MarketService buy: $err');
      }
    } finally {
      client.close();
    }
    return orderModel;
  }

  Future<bool> qualify(OrderModel order) async {
    var client = http.Client();
    try {
      final resp =
          await client.patch(Uri.parse('$kDomain$_urlQualify/${order.id}'),
              headers: {
                'Authorization': 'Bearer ${prefs.token}',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({"scoreClient": order.scoreClient}));
      if (resp.statusCode == 200) return true;
    } catch (err) {
      if (kDebugMode) {
        print('MarketService deliveryCost: $err');
      }
    } finally {
      client.close();
    }
    return false;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/src/models/address_model.dart';
import 'package:planck/src/models/balance_model.dart';
import 'package:planck/src/models/cart_summary_model.dart';
import 'package:planck/src/models/fee_model.dart';
import 'package:planck/src/models/product_model.dart';
import 'package:planck/src/provider/db_provider.dart';
import 'package:planck/src/services/balance_service.dart';
import 'package:planck/src/services/market_service.dart';
import 'package:planck/src/services/payment_service.dart';

class CartSummaryController extends ChangeNotifier {
  final MarketService marketService = MarketService();

  final List<CartSummaryModel> _summaries = [];

  double _money = 0.0;

  double get money => _money;

  set money(double money) {
    _money = money;
    notifyListeners();
  }

  bool _inAsyncCall = false;

  CartSummaryController() {
    load();
  }

  List<CartSummaryModel> get summaries => _summaries;

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  load() async {
    inAsyncCall = true;
    await loadDeliveryFee();
    await loadBalance();
    inAsyncCall = false;
  }

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  loadDeliveryFee() async {
    _products = await DBProvider.db.loadProducts();
    var companyIds = [];
    for (var product in products) {
      if (!companyIds.contains(product.companyId)) {
        companyIds.add(product.companyId);
      }
    }
    _address = await DBProvider.db.loadAddress();
    if (_address == null) {
      _summaries.clear();
      return;
    }
    List<FeeModel> fees = await marketService.deliveryCost(
        companyIds.join(','), _address!.location.x, _address!.location.y);
    _summaries.clear();
    for (var fee in fees) {
      _summaries.add(CartSummaryModel(
          fee: fee,
          products:
              products.where((pr) => pr.companyId == fee.companyId).toList()));
    }
  }

  AddressModel? _address;

  Future<bool> buy(int typePayment) async {
    if (_address == null) {
      _summaries.clear();
      return false;
    }
    inAsyncCall = true;
    for (var cartSummary in _summaries) {
      await marketService.buy(cartSummary, _address!, typePayment);
    }
    await DBProvider.db.deleteAllProduct();
    inAsyncCall = false;
    return true;
  }

  double get total {
    double total = 0.0;
    for (var summary in summaries) {
      total += summary.total;
    }
    return total;
  }

  final BalanceService balanceService = BalanceService();

  loadBalance() async {
    BalanceModel? balance = await balanceService.getBalance();
    if (balance == null) return;
    money = balance.money;
  }

  final PaymentService paymentService = PaymentService();

  Future<bool> makePayment(
      {required double money, required String currency}) async {
    try {
      inAsyncCall = true;
      Map<String, dynamic>? paymentIntentData =
          await paymentService.payment(products, money, currency);

      if (paymentIntentData != null &&
          paymentIntentData.containsKey('response') &&
          paymentIntentData.containsKey('id')) {
        Map<String, dynamic> response = paymentIntentData['response'];

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: kNameApp,
            customerId: response['customer'],
            paymentIntentClientSecret: response['client_secret'],
            customerEphemeralKeySecret: response['ephemeralKey'],
          ),
        );
        return await displayPaymentSheet(paymentIntentData['id']);
      } else {
        inAsyncCall = false;
      }
    } catch (error) {
      inAsyncCall = false;
      if (kDebugMode) {
        print("CartSummaryController makePayment :$error");
      }
    }
    return false;
  }

  Future<bool> displayPaymentSheet(int paymentId) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return await paymentService.confirm(paymentId);
    } on Exception catch (error) {
      if (error is StripeException) {
        if (kDebugMode) {
          print(
              "CartSummaryController displayPaymentSheet error from Stripe :$error");
        }
      } else {
        if (kDebugMode) {
          print(
              "CartSummaryController displayPaymentSheet error Unforeseen :$error");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("CartSummaryController displayPaymentSheet error :$error");
      }
    } finally {
      inAsyncCall = false;
    }
    paymentService.cancel(paymentId);
    return false;
  }
}

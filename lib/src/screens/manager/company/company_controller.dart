import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:planck/src/models/store_company_model.dart';
import 'package:planck/src/services/store_manager_service.dart';

class CompanyController extends ChangeNotifier {
  final StoreManagerService _storeManagerService = StoreManagerService();

  List<StoreCompanyModel> _companies = [];

  List<StoreCompanyModel> get companies => _companies;

  CompanyController() {
    load();
  }

  bool _inAsyncCall = false;

  bool get inAsyncCall => _inAsyncCall;

  set inAsyncCall(bool asyncCall) {
    _inAsyncCall = asyncCall;
    notifyListeners();
  }

  load() async {
    inAsyncCall = true;
    _companies = await _storeManagerService.getCompanies();
    inAsyncCall = false;
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:involys_mobile_app/Config/ApiConstants.dart';
import '../../../cache/cacheHelper.dart';
import '../../Authentication/Logic/UserData.dart';
import '../Models/dataModel.dart';
import '../Services/api_service.dart';
import '../Services/dataProcessing.dart';

class DataNotifier with ChangeNotifier {
  final ApiService apiService;

  Map<String, Object?> jSON = {};
  grapheModel? _DATA;
  List<String> _WIDGET = [];
  List<dynamic> _CompaniesData = [];
  String _widgetName = '-1';
  String _idSociety = '';
  String _serverUrl = '';



  DataNotifier(this.apiService) {
    _idSociety = CacheData.getData(key: 'CompanyId'+UserData.UserId!) ?? "-1";
    _serverUrl = CacheData.getData(key: 'serverUrl') ?? 'http://105.73.90.178:9070';
    print("Dasboard provider launched");
  }

  update(){
    _idSociety = CacheData.getData(key: 'CompanyId'+UserData.UserId!) ?? "-1";
    _serverUrl = CacheData.getData(key: 'serverUrl') ?? 'http://105.73.90.178:9070';
    notifyListeners();

  }

  bool _isError = false; // Flag to track if data has been fetched
  bool get isError => _isError;
  grapheModel? get data => _DATA;
  List<String> get widgets => _WIDGET;
  List<dynamic> get companiesData => _CompaniesData;
  String get widgetName => _widgetName;
  String get idSociety => _idSociety;
  String get serverUrl => _serverUrl;

  set widgetName(String newName) {
    _widgetName = newName;
    notifyListeners();
  }
  set idSociety(String newId) {
    _idSociety = newId;
    notifyListeners();
  }

  set serverUrl(String newServerUrl) {
    _serverUrl = newServerUrl;
    notifyListeners();
  }

  bool _ServerError = false; // Flag to track if data has been fetched
  bool get ServerError => _ServerError;

  Future<void> checkServerUrl(String EnteredUrl) async {

      List listCompanies = await apiService.fetchCompaniesData(EnteredUrl);
      print(listCompanies);
      if(listCompanies.isEmpty){
        _ServerError=true;

        notifyListeners();
      }else{
        _ServerError=false;
      }
      notifyListeners();


  }




  bool isLoading=false;
  Future<void> GetData(String idCompany, String widget) async {
    try {
      isLoading=true;

        List companiesData = await apiService.fetchCompaniesData(serverUrl);
        _CompaniesData = companiesData;


      if (idCompany == "-1") {
        print("nothing is saved");
        Map<String, dynamic> companieData = _CompaniesData[0];
        idCompany = companieData['id'];
      }



      List<dynamic> DashBoardData = await apiService.fetchDashBoardData(idCompany,serverUrl);
      _WIDGET.clear();
      _WIDGET.addAll(DashBoardData.map((element) => element['designation']));

      if (widget == "-1") {
        jSON = await DashBoardData[0];
      } else {
        for (var element in DashBoardData) {
          String TitleWidget = element['designation'];
          if (widget == TitleWidget) {
            // print("TitleWidget: $TitleWidget");
            jSON = element;
            break;
          }
        }
      }


      _DATA = await DataProcessing(jSON);
      isLoading=false;
      _isError=false;
      notifyListeners();


    } catch (e) {
      print('Error fetching data: $e');
      _isError=true;
      notifyListeners();
      // return null;
    }
  }




}


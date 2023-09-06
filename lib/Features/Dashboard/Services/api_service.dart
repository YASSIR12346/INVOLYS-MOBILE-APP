import 'package:dio/dio.dart';
import 'package:involys_mobile_app/Config/ApiConstants.dart';

import '../../Authentication/Logic/UserData.dart';

class ApiService {
 

  Future<List<dynamic>> fetchCompaniesData(String serverUrl) async {
    final apiCompany = "$serverUrl/PraxisApi/api/v1/Users/Companies";

    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer ' + UserData.Token!;

    try {
      final response = await dio.get(apiCompany);
      if (response.statusCode == 200) {
        final jsonData = response.data;
        return jsonData;
      } else {
        print('Failed to fetch companies data');
        return []; // Return an empty list on error
      }
    } catch (e) {
      print('An error occurred: $e');
      return []; // Return an empty list on error
    }
  }



  Future<List<dynamic>> fetchDashBoardData(String idCompany,String serverUrl) async {
    final apiDash = "$serverUrl/DashboardApi/api/v1/Dashboards/";
  
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer ' + UserData.Token!;
    dio.options.headers['Companies'] = idCompany;

    try {
      final response = await dio.get(apiDash);
      if (response.statusCode == 200) {
        final jsonData = response.data;
        return jsonData;
      } else {
        print('Failed to fetch dashboard data');
        return []; // Return an empty list on error
      }
    } catch (e) {
      print('An error occurred: $e');
      return []; // Return an empty list on error
    }
  }





}


import 'package:flutter/material.dart';

import '../../../Shared/colors.dart';
import '../Models/dataModel.dart';

grapheModel DataProcessing (Map<String, dynamic?> dataWidget ){



  grapheModel liste;




  List<dynamic> dashboardWidgets = dataWidget['dashboardWidgets'] ;

  List<Data> resultsList = [];
  List<List<Data>> allGraphes = [];
  List<String> ListdesignationWidget=[];
  List<dynamic> ListdesTypeWidget=[];


  dashboardWidgets.forEach((widget) {
    Map<String, dynamic> widgets= widget['widget'];
    List<Data> data = [];

    //Switch according to wigetType


    dynamic TypeWidget=widgets['widgetType'];


    switch (TypeWidget) {
      case 1:
        print('Typewidget: is Calender');

        ListdesTypeWidget.add(TypeWidget);
        allGraphes.add([]);


        break;
      case 2:
        print('Typewidget: is Card');



        if(widgets['result']!= null) {

          String designationWidget= widgets['designation'] as String;

          Map<String, dynamic> results = widgets['result'];


          Data elementData = Data(
            name: results['label'],
            percent: results['value'].toDouble(),
            color: Colors.black,
            colorOpac: Color(0xff004899),
          );
          data.add(elementData);
          ListdesignationWidget.add( designationWidget);
          allGraphes.add(data);
          ListdesTypeWidget.add(TypeWidget);
        }


        break;
      case 3:
        print('Typewidget: is Pie Chart');
        if( !widgets['results'].isEmpty) {

          String designationWidget= widgets['designation'] as String;

          List<dynamic> results = widgets['results'];
          while(results.length> AppColors.colorsPaletteData.length ){
            AppColors.generateRandomColorPair();
          }

          int i=0;
          results.forEach((element) {

            Map<String, dynamic> result = element;

            Data elementData = Data(
                name: result['label'],
                percent: result['value'].toDouble(),
                color: AppColors.colorsPaletteData[i][0],
                colorOpac: AppColors.colorsPaletteData[i][1]
            );
            data.add(elementData);

            i++;
          });
          ListdesignationWidget.add( designationWidget);
          allGraphes.add(data);
          ListdesTypeWidget.add(TypeWidget);
        }
        break;
      default:
        print('Selected choice is unknown');
    }











  });





  /**/

  // liste={
  //   'grapheData': allGraphes,
  //   'titleData': ListdesignationWidget,
  //   'TypesData': ListdesTypeWidget,
  // };

  liste= grapheModel(grapheData: allGraphes, titleData: ListdesignationWidget, typesData: ListdesTypeWidget);


  return liste;



}


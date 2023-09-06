import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Dashboard/Provider/DashboardProvider.dart';
import '../Provider/appProvider.dart';

class CustomSearchDelegate extends SearchDelegate{





  @override
  ThemeData appBarTheme(BuildContext context) {

      return ThemeData(
      textTheme: TextTheme(
      
        headline6: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary),
      ),
      appBarTheme:  AppBarTheme(
        backgroundColor: Theme.of(context).colorScheme.primary,

            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
            ),
            actionsIconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
            ),



      ),



        inputDecorationTheme:
        InputDecorationTheme(

          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          filled: true,
          fillColor: Color.fromARGB(255, 221, 221, 221), 

          enabledBorder:  OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),


          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide:  BorderSide(color: Colors.blueGrey ),

          ),



          hintStyle: TextStyle(fontSize: 18, color: Colors.blueGrey),

        ),





      );
  }









  List<Map<String,dynamic>> searchTerms= [];
  @override
  List<Widget>? buildActions(BuildContext context) {
   

  }

  @override
  Widget? buildLeading(BuildContext context) {
    searchTerms=[];
    final provider = Provider.of<DataNotifier>(context, listen: false);
    int i=0;

    if(provider != null && provider.data != null){
      provider.data!.titleData.forEach((element) {
        searchTerms.add({
          "index":i, "value": element
        });
        i++;
      });
    }else{
      searchTerms = [];
    }


    return IconButton(onPressed: (){
  close(context, null);

}, icon: const Icon(Icons.arrow_back));

  }

  @override
  Widget buildResults(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    List<Map<String,dynamic>> matchQuery=[];
    for(var widget in searchTerms){
      if(widget["value"].toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(widget);
      }
    }

    return ListView.separated(
      itemCount: matchQuery.length,
        separatorBuilder: (context, index) =>
            Divider(),

        itemBuilder: (context, index){
          var result = matchQuery[index];
          return ListTile(
            title: Text(result["value"]),
            onTap: () async {
              appProvider.scrollToItem(result["index"]);
              Navigator.of(context).pop(true);
            },
          );
        }


    );




    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<Map<String,dynamic>> matchQuery= [];
    for(var widget in searchTerms){
      if(widget["value"].toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(widget);
      }
    }
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    return ListView.separated(
        itemCount: matchQuery.length,
        separatorBuilder: (context, index) =>
            Divider(),

        itemBuilder: (context, index){
          var result = matchQuery[index];
          return ListTile(
            title: Text(result["value"]),
            onTap: () async {
              appProvider.scrollToItem(result["index"]);
              Navigator.of(context).pop(true);
            },
          );
        }


    );




  }


  
  
  
  
}


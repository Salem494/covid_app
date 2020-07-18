import 'dart:convert';
import 'package:covid19/date_source.dart';
import 'package:covid19/pages/country_page.dart';
import 'package:covid19/panel/info_panel.dart';
import 'package:covid19/panel/most_effected_countries.dart';
import 'package:covid19/panel/world_wide_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;

  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countriesData;

  fetchCountriesData() async {
    http.Response response = await http.get(
        'https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countriesData = json.decode(response.body);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWorldWideData();
    fetchCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: Text('COVID-19'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 8,
              margin: EdgeInsets.all(10),

              child: Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: Colors.orange[100],
                child: Text(
                    DataSource.quote,
                    style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.lightBlue,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'All World',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>CountryPage()
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[800],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Regional',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null ? CircularProgressIndicator() : WorldWidePanel(
              worldWide: worldData,),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 10),
               child: Text(
                 'Most affected countries',
                 style: TextStyle(
                   fontSize: 22,
                   fontWeight: FontWeight.bold
                 ),
               ),
             ),
             SizedBox(height: 10,),
            countriesData == null ? Container() : MostAffectedPanel(countryData: countriesData,),
            SizedBox(height: 5),
            InfoPanel(),
            SizedBox(height: 5),
              Center(
                child: Text('WE ARE TOGETHER IN THIS :',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue
                ),),
              ),
            SizedBox(height: 30),
            Center(
              child: Card(
                elevation: 8,
                color: Colors.grey[300],
                child: Text('Made By El_Salem',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}



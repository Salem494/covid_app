import 'package:covid19/date_source.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQS'),
        elevation: 7,
        centerTitle: true,
        backgroundColor: Colors.grey[500],
      ),
      body: ListView.builder(
          itemCount:DataSource.questionAnswers.length ,
          itemBuilder: (context,index){
          return Card(
            elevation: 7,
            color: Colors.grey[50],
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(DataSource.questionAnswers[index]['question']),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                    child: Text(DataSource.questionAnswers[index]['answer'])),
              ],
            ),
          );
          }
      ),
    );
  }
}

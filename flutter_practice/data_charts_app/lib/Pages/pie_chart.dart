import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:data_charts_app/pie_chart_values.dart';

class PieChartPage extends StatefulWidget{
  @override
  State<PieChartPage> createState() => PieChartPageState(); 
}

class PieChartPageState extends State<PieChartPage>{
  bool showList=true;
  TextEditingController titleController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  List<Map<String, dynamic>> chartData = [
  {"title": "food", "value": 20.0},
  {"title": "transport", "value": 10.0},
];
  // PieChartValues updateList=PieChartValues();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [SizedBox(height: 50,),
          Stack(
            children: [
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: chartData.map((data) {
                      return PieChartSectionData(
                        value: data["value"],
                        title: data["title"],
                        radius: 70,
                        showTitle: true,
                      );
                  }).toList(),
                  ),
                ),
              ),
              
            ],
          ),
          SizedBox(height:20),
          
          if(showList)
            Expanded(
              child: ListView.builder(
              itemCount: chartData.length,
              itemBuilder: (BuildContext centext,int index){
                return ListTile(
                   title: Text(chartData[index]["title"]),
                   trailing: Text(chartData[index]["value"].toString()),
                );
              },
            ),
          ),
          TextButton(onPressed: ()=>setState(() {
            if(showList){
              showList=false;
            }
            else{
              showList=true;
            }
          }), child: Text("Show List")),
          SizedBox(height:20),
          GestureDetector(
            onTap: () {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Data"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Value"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                chartData.add({
                  "title": titleController.text,
                  "value": double.parse(valueController.text),
                });
              });

              titleController.clear();
              valueController.clear();
              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      );
    },
  );
},
            child: Stack(
              alignment: Alignment.center,
              children: [   
                Container(
                  width: 80,         
                  height: 80,
                  decoration: BoxDecoration(
                  shape:BoxShape.circle,
                  color: Colors.blue[300]
                )
                ),
                Transform.translate(
                offset: Offset(0, -8),
                child:Text("+",style:TextStyle(fontSize: 80))
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


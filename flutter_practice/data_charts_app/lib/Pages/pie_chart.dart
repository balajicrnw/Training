import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:data_charts_app/pie_chart_values.dart';

class PieChartPage extends StatefulWidget{
  @override
  State<PieChartPage> createState() => PieChartPageState(); 
}

class PieChartPageState extends State<PieChartPage>{
  bool showList=true;
  int list_count=1;
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
                    sections:[
                      PieChartSectionData(
                        value:20,
                        title:"food",
                        showTitle:true,
                        radius: 70
                      ),
                      PieChartSectionData(
                        value:10,
                        title:"transport",
                        showTitle:true,
                        radius: 70
                  
                      ),
                      PieChartSectionData(
                        value:20,
                        title:"rent",
                        showTitle:true,
                        radius: 70
                      ),
                      PieChartSectionData(
                        value:20,
                        title:"clothes",
                        showTitle:true,
                        radius: 70
                      ),
                      PieChartSectionData(
                        value:30,
                        title:"savings",
                        showTitle:true,
                        radius: 70
                      )     
                    ],
                  ),
                ),
              ),
              if(showList)
            Expanded(
              child: ListView.builder(
              itemCount: list_count,
              itemBuilder: (BuildContext centext,int index){
                return Text("data");
              },
            ),
          ),
            ],
          ),
          SizedBox(height:20),
          
          
          SizedBox(height:20),
          GestureDetector(
            onTap: () => setState(() {
              list_count++;
            }),
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
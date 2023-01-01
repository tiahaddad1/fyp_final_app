// import 'dart:html';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/feelingsComponent.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Model/FeelingsData.dart';

class caregiverFeelings extends StatefulWidget {
  const caregiverFeelings({super.key});

  @override
  State<caregiverFeelings> createState() => _caregiverFeelingsState();
}

class _caregiverFeelingsState extends State<caregiverFeelings> {
  late List<FeelingsData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _chartData = getData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 251, 251, 251),
          toolbarHeight: 50,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(5),
              primary: Color.fromARGB(255, 251, 251, 251),
            ),
            icon: Icon(Icons.arrow_back_ios_new,
                color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () => Navigator.of(context).pop(),
            label: const Text(
              "",
            ),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 251, 251, 251),
                        border: Border(
                          bottom: BorderSide(
                              width: 5.0,
                              color: Color.fromARGB(255, 64, 119, 110)),
                        ),
                      ),
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(0),topRight: Radius.circular(0))),
                      height: MediaQuery.of(context).size.height / 2.25,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25, right: 10),
                              child: Text(
                                "Today's feelings",
                                style: TextStyle(
                                    fontFamily: "Cabin-Regular",
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              child: Image.asset(
                                "lib/assets/feelingsDetailIcon.png",
                                width: 60,
                                height: 60,
                              ),
                              padding: EdgeInsets.only(left: 5, right: 25),
                            )
                          ],
                        ),
                        Expanded(
                            child: SafeArea(
                                child: ListView(
                                    padding: EdgeInsets.only(top: 20),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                              Center(
                                  child: Wrap(children: [
                                feelingComp(feeling: "Happy", time: "18:30"),
                                feelingComp(feeling: "Happy", time: "18:30"),
                                feelingComp(feeling: "Happy", time: "18:30"),
                              ]))
                            ]))),
                      ]),
                    )),
                Container(
                    width: double.infinity / 1.5,
                    height: 500,
                    child: Column(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 20),
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                        child: Text(
                          "Weekly summary",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                              fontFamily: "Cabin-Regular"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15, left: 5, right: 15),
                        child: generateChart(),
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 20,
                              icon: const Icon(Icons.download),
                              onPressed: () {
                                downloadCsv();
                              },
                            ),
                            Text(
                              "Download a CSV file of weekly report",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      )
                    ])),
              ],
            )));
  }

  List<FeelingsData> getData() {
    final List<FeelingsData> chartData = [
      FeelingsData(1, 1),
      FeelingsData(6, 1),
      FeelingsData(5, 2),
      FeelingsData(1, 2),
      FeelingsData(4, 2),
      FeelingsData(1, 3),
      FeelingsData(3, 3),
      FeelingsData(4, 3),
      FeelingsData(5, 4),
      FeelingsData(6, 4),
      FeelingsData(5, 4),
      FeelingsData(6, 5),
      FeelingsData(2, 5),
      FeelingsData(4, 5),
      FeelingsData(2, 6),
      FeelingsData(1, 6),
      FeelingsData(2, 6),
      FeelingsData(1, 7),
      //dummy data
    ];
    return chartData;
  }

  generateChart() {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      enableAxisAnimation: true,
      series: <ChartSeries>[
        BarSeries<FeelingsData, int>(
            color: Color.fromARGB(255, 64, 119, 110),
            dataSource: _chartData,
            xValueMapper: (FeelingsData feelingsData, _) =>
                feelingsData.feelingsRate,
            yValueMapper: (FeelingsData feelingsData, _) =>
                feelingsData.dayOfWeek,
            enableTooltip: true),
      ],
      primaryXAxis: CategoryAxis(
          title: AxisTitle(
              text: "Feelings (1-6)", textStyle: TextStyle(fontSize: 13))),
      primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          title: AxisTitle(
              text: "Days of the week (1-7)",
              textStyle: TextStyle(fontSize: 13))),
    );
  }

  downloadCsv() async {
    DateTime today = new DateTime.now();
    // ignore: deprecated_member_use
    late List<List<dynamic>> rows = [];

    for (int i = 0; i < getData().length; i++) {
      List<dynamic> row = [];
      row.add(getData()[i].dayOfWeek);
      row.add(getData()[i].feelingsRate);
      rows.add(row);
    }
    String dir = (await getApplicationDocumentsDirectory())!.absolute.path +
        "/documents";

    String file = "$dir";
    print(" FILE " + file);
    File f = new File(file + "weekly_summary_$today.csv");

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
  }
}

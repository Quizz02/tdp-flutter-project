import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tdp_flutter_project/models/staticReport.dart';
import 'package:tdp_flutter_project/providers/user_provider.dart';
import 'package:tdp_flutter_project/ui/navbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  double rest = 0;

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    setState(() {
      isLoading = true;
    });
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    setState(() {
      isLoading = false;
    });
  }

  Map<String, double> dataMap1 = {
    "Robos al paso": 64.0,
    "resto": 36,
    // "Intento de robo": 90.0,
  };

  Map<String, double> dataMap2 = {
    "Asalto con Arma": 40.0,
    "resto": 60.0,
    // "Intento de robo": 90.0,
  };

  Map<String, double> dataMap3 = {
    "Intento de Robo": 90.0,
    "resto": 10,
    // "Intento de robo": 90.0,
  };

  List<Color> colorList1 = [
    const Color(0xff3EE094),
    Color.fromARGB(230, 226, 225, 225)
    // const Color(0xff3398F6),
  ];

  List<Color> colorList2 = [
    const Color(0xffFA4A42),
    Color.fromARGB(230, 226, 225, 225)
    // const Color(0xff3EE094),
    // const Color(0xff3398F6),
  ];

  List<Color> colorList3 = [
    const Color(0xff3398F6),
    Color.fromARGB(230, 226, 225, 225)
    // const Color(0xff3EE094),
  ];

  @override
  Widget build(BuildContext context) {
    List<StaticReport> reportsList = [];
    String id = '';
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(title: Text('Inicio')),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          child: Text(
                            "Resumen Semanal",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Text(
                              "Situaciones más comunes de la semana",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.greenAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text("Robos al Paso"),
                            SizedBox(
                              height: 20,
                            ),
                            PieChart(
                              initialAngleInDegree: 270,
                              dataMap: dataMap1,
                              colorList: colorList1,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 4,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 12,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                showLegends: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text("Asalto con Arma"),
                            SizedBox(
                              height: 20,
                            ),
                            PieChart(
                              initialAngleInDegree: 270,
                              dataMap: dataMap2,
                              colorList: colorList2,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 4,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 12,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                showLegends: false,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text("Intento de Robo"),
                            SizedBox(
                              height: 20,
                            ),
                            PieChart(
                              initialAngleInDegree: 270,
                              dataMap: dataMap3,
                              colorList: colorList3,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 4,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 12,
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              legendOptions: LegendOptions(
                                showLegends: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Text(
                              "Publicación con mayor repercursión",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('reports')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            for (var i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              final snap = snapshot.data!.docs[i].data();
                              StaticReport temp = StaticReport(
                                  snap['likes'].length,
                                  snap['reportId'],
                                  snap['uid'],
                                  snap['firstname'],
                                  snap['lastname'],
                                  snap['description'],
                                  snap['reference'],
                                  snap['reportUrl']);
                              if (reportsList.contains(temp)) {
                                continue;
                              }
                              reportsList.add(temp);
                            }
                            reportsList
                                .sort((a, b) => a.likes.compareTo(b.likes));
                            StaticReport bestReport = reportsList.last;
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                                              ),
                                              backgroundColor: Colors.grey,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      bestReport.firstname +
                                                          ' ' +
                                                          bestReport.lastname,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    // padding: const EdgeInsets.symmetric(
                                    //   horizontal: 16,
                                    // ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                                children: [
                                                  TextSpan(
                                                    text: bestReport.likes
                                                            .toString() +
                                                        ' likes',
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                                children: [
                                                  TextSpan(
                                                    text: bestReport.reference,
                                                  ),
                                                ]),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DefaultTextStyle(
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontWeight: FontWeight.w800),
                                          child: Text(
                                            bestReport.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    width: double.infinity,
                                    child: Image.network(
                                      bestReport.reportUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Ver todos los 20 comentarios',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '30/08/2022',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            child: Text(
                              "Usuarios con mayores reportes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 12,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: Text(
                                    "Matias Beteta",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  child: Text(
                                    "15",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 8,
                          thickness: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 12,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: Text(
                                    "David Castañeda",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  child: Text(
                                    "12",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 8,
                          thickness: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 12,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: Text(
                                    "Rafael Bartra",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  child: Text(
                                    "8",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

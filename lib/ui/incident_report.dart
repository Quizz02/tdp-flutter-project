import 'package:flutter/material.dart';

class IncidentReport extends StatefulWidget {

  @override
  State<IncidentReport> createState() => _IncidentReportState();
}

class _IncidentReportState extends State<IncidentReport> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportar Incidente')
      ),
      body: Container(),
    );
  }
}

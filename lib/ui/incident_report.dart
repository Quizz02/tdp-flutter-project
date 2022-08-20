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
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget> [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Categoría'
                ),
              ),
              Divider(
                color: Colors.white24,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Descripción (opcional)'
                ),
              ),
              Divider(
                color: Colors.white24,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Foto (opcional)'
                ),
              ),
              Divider(
                color: Colors.white24,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ubicación del suceso'
                ),
              ),
              Divider(
                color: Colors.white24,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Referencia del lugar'
                ),
              )
            ]
          )
        )
      )
    );
  }


}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class IncidentReport extends StatefulWidget {
  @override
  State<IncidentReport> createState() => _IncidentReportState();
}

class _IncidentReportState extends State<IncidentReport> {
  String dropdowncurrentvalue = 'Seleccione una categoria';
  List<String> categories = [
    'Hurto',
    'Hurto Agravado',
    'Robo',
    'Robo Agravado',
    'Homicidio Calificado',
    'Microcomercializacion de drogas'
  ];

  String? categoryvalue = 'Robo';

  @override
  Widget build(BuildContext context) {
    final description = TextEditingController();
    return Scaffold(
        appBar: AppBar(title: Text('Reportar Incidente')),
        body: Column(children: <Widget>[
          Container(
            height: 120,
            width: 360,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Categoria',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                DropdownButtonFormField<String>(
                  alignment: Alignment.topCenter,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  )),
                  value: categoryvalue,
                  isExpanded: true,
                  iconSize: 30,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  items: categories
                      .map((categoria) => DropdownMenuItem(
                          value: categoria,
                          child: Text(
                            categoria,
                            style: TextStyle(fontSize: 16),
                          )))
                      .toList(),
                  onChanged: (categoria) =>
                      setState(() => categoryvalue = categoria),
                ),
              ],
            ),
          ),
          TextField(
            controller: description,
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
          )
        ]));
  }

  // Widget _buildForm() {
  //   return Container(
  //     padding: EdgeInsets.all(20),
  //     child: Scaffold(
  //       body: Container(
  //         child: Column(
  //           children: <Widget> [
  //             DropdownButton(
  //               items: categorias.map((String a){
  //                 return DropdownMenuItem(
  //                   value: a,
  //                   child: Text(a));
  //               }).toList(),
  //               onChanged: (_value)=>{
  //                 setState((){
  //                   _placeholder = _value;
  //                 })
  //               },
  //               hint: Text(_placeholder),
  //               ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Categoría'
  //               ),
  //             ),
  //             Divider(
  //               color: Colors.white24,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Descripción (opcional)'
  //               ),
  //             ),
  //             Divider(
  //               color: Colors.white24,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Foto (opcional)'
  //               ),
  //             ),
  //             Divider(
  //               color: Colors.white24,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Ubicación del suceso'
  //               ),
  //             ),
  //             Divider(
  //               color: Colors.white24,
  //             ),
  //             TextField(
  //               decoration: InputDecoration(
  //                 labelText: 'Referencia del lugar'
  //               ),
  //             )
  //           ]
  //         )
  //       )
  //     )
  //   );
  // }

}

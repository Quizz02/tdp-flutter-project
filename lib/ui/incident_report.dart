// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tdp_flutter_project/providers/user_provider.dart';
import 'package:tdp_flutter_project/services/storage_service.dart';
import 'package:tdp_flutter_project/utils/utils.dart';

import '../models/user.dart';
import '../services/firestore_service.dart';
import '../utils/utils.dart';

class IncidentReport extends StatefulWidget {
  @override
  State<IncidentReport> createState() => _IncidentReportState();
}

class _IncidentReportState extends State<IncidentReport> {
  String? categoryvalue = 'Robo';
  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  File? image;
  Uint8List? _image;
  Uint8List? _file;
  final _descriptionController = TextEditingController();
  final _referenceController = TextEditingController();

  List<String> categories = [
    'Hurto',
    'Hurto Agravado',
    'Robo',
    'Robo Agravado',
    'Homicidio Calificado',
    'Microcomercializacion de drogas'
  ];

  void postReport(
    String uid,
    String firstname,
    String lastname,
  ) async {
    try {
      String res = await FirestoreMethods().uploadReport(
          _descriptionController.text,
          _file!,
          uid,
          firstname,
          lastname,
          _referenceController.text,
          categoryvalue!);

      if (res == 'Éxito') {
        showSnackbar('Reporte publicado', context);
      } else {
        showSnackbar(res, context);
      }
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _referenceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final StorageMethods storage = StorageMethods();
    const maxLines = 5;
    const widthDefault = 340.0;

    return Scaffold(
        appBar: AppBar(title: Text('Reportar Incidente')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Categoria',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: widthDefault,
                    alignment: Alignment.center,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      value: categoryvalue,
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
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hora',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: widthDefault,
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      '${time.hour}:${time.minute}',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    child: Text(
                      'Seleccionar Hora',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if (newTime == null) return;

                      setState(() => time = newTime);
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descripción (Opcional)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: widthDefault,
                    height: maxLines * 25.0,
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: maxLines,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Foto (Opcional)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: widthDefault,
                    height: 40,
                    child: MaterialButton(
                        color: Colors.red,
                        child: Text(
                          'Escoge una Imagen de la Galería',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          Uint8List file = await pickImage(ImageSource.gallery);
                          setState(() {
                            _file = file;
                          });
                        }),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: widthDefault,
                    height: 40,
                    child: MaterialButton(
                        color: Colors.red,
                        child: Text(
                          'Toma una Foto',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          Uint8List file = await pickImage(ImageSource.camera);
                          setState(() {
                            _file = file;
                          });
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ubicación del suceso',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: widthDefault,
                    height: 360,
                    child: Image.network(
                        'https://www.google.com/maps/d/u/0/thumbnail?mid=11P5T6CF82lCKcWO43fsBLDNUGic'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: widthDefault,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Referencia del lugar',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: widthDefault,
                    height: maxLines * 17.0,
                    child: TextField(
                      controller: _referenceController,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: widthDefault,
                    height: 40,
                    child: MaterialButton(
                        color: Colors.red,
                        child: Text(
                          'Enviar Reporte',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          postReport(user.uid, user.firstname, user.lastname);
                        }),
                  ),
                  SizedBox(height: 20),
                ]),
          ),
        ));
  }
}

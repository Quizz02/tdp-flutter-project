// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class IncidentReport extends StatefulWidget {
  @override
  State<IncidentReport> createState() => _IncidentReportState();
}

class _IncidentReportState extends State<IncidentReport> {
  String dropdowncurrentvalue = 'Seleccione una categoria';
  String? categoryvalue = 'Robo';

  List<XFile>? _image;
  // final imagePicker = ImagePicker();
  List<String> downloadURL = [];
  List<String> urls = [];
  var isLoading = false;
  int uploadItem = 0;
  // UploadTask? uploadTask;

  List<String> categories = [
    'Hurto',
    'Hurto Agravado',
    'Robo',
    'Robo Agravado',
    'Homicidio Calificado',
    'Microcomercializacion de drogas'
  ];

  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Fallo al escoger imagen: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Fallo al escoger imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const maxLines = 5;
    const widthDefault = 340.0;

    // final description = TextEditingController();
    String _descriptionTextValue = "";
    // final reference = TextEditingController();
    String _referenceTextValue = "";

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
                    // color: Colors.red,
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
                    // color: Colors.green,
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
                    // color: Colors.red,
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
                      // controller: description,
                      maxLines: maxLines,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      onSubmitted: (value) {
                        setState((){
                          _descriptionTextValue = value;
                        });
                      },
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
                        onPressed: () {
                          pickImage();
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
                        onPressed: () {
                          pickImageCamera();
                        }),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.grey[300],
                    child: image != null
                        ? Image.file(image!)
                        : Container(
                            alignment: Alignment.center,
                            child: Text(
                              'No hay ninguna imagen seleccionada',
                              textAlign: TextAlign.center,
                            ),
                          ),
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
                    // color: Colors.green,
                    child: TextField(
                      // controller: reference,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                      onSubmitted: (value) {
                        setState((){
                          _referenceTextValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: widthDefault,
                    height: 40,
                    child: MaterialButton(
                        // color: Colors.grey[300],
                        color: Colors.red,
                        child: Text(
                          'Enviar Reporte',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                        }),
                  ),
                  SizedBox(height: 20),
                ]),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ComunityFeed extends StatefulWidget {
  @override
  State<ComunityFeed> createState() => _ComunityFeedState();
}

class _ComunityFeedState extends State<ComunityFeed> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
        appBar: AppBar(title: Text('Comunidad')),
        body: Center(
        ));
  }
}

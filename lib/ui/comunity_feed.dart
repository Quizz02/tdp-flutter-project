import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdp_flutter_project/widgets/report_card.dart';
import '../services/storage_service.dart';

class ComunityFeed extends StatefulWidget {
  @override
  State<ComunityFeed> createState() => _ComunityFeedState();
}

class _ComunityFeedState extends State<ComunityFeed> {
  @override
  Widget build(BuildContext context) {
    final StorageMethods storage = StorageMethods();
    return Scaffold(
      appBar: AppBar(title: const Text('Comunidad')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) =>
              ReportCard(
                snap: snapshot.data!.docs[index].data(),
              ),
          );
        },
      ),
    );
  }
}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../services/storage_service.dart';
import '../widgets/report_card.dart';

class MyReports extends StatefulWidget {
  // const MyReports({Key? key}) : super(key: key);
  final user;
  const MyReports({Key? key, required this.user}) : super(key: key);

  @override
  State<MyReports> createState() => _MyReportsState(user);
}

class _MyReportsState extends State<MyReports> {
  CollectionReference ref = FirebaseFirestore.instance.collection('reports');

  _MyReportsState(user);

  filterReports() async{
    await ref.where('uid',isEqualTo: widget.user.uid.toString()).get().then((value) {
      value.docs.forEach((element) {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;
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
              itemBuilder: (context, index) {

                return ReportCard(
                  snap: snapshot.data!.docs[index].data(),
                );
              });
        },
      ),
    );
  }
}

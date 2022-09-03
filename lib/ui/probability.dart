import 'package:flutter/material.dart';
import '../widgets/map_widget.dart';


class Probability extends StatefulWidget {
  @override
  State<Probability> createState() => _ProbabilityState();
}

class _ProbabilityState extends State<Probability> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Probabilidad')),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 400,
              width: 400,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: MapSample(),
              ),
            ),
            Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
        }),
        label: Text('A Los Olivos'),
        icon: Icon(Icons.arrow_forward),
      ),
    );
  }

}

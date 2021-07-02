import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    print('rebuilding again...crying');
    return Container(
      child: Center(
        child: Text('History'),
      ),
    );
  }
}

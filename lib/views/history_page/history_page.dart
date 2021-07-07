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
      child: Stack(
        children: [
          Image.network(
              "https://i.pinimg.com/originals/b7/cd/5f/b7cd5f4b3eb91bc06ac4f790f019b323.jpg"),
          Text('History')
        ],
      ),
    );
  }
}

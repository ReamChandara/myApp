import 'package:flutter/material.dart';

class DetailHome extends StatefulWidget {
  const DetailHome({Key? key}) : super(key: key);

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Home"),
      ),
    );
  }
}

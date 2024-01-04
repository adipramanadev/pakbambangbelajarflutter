import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DashBoard(),
    );
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  //function getData
  Future getData() async {
    final String url = "http://192.168.100.57:8000/api/get-crud";

    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      // print(response.body)['data'];
      return json.decode(response.body)['data'];
    } else {
      print('data ga tampil');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Flutter'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          } else {
            List<dynamic> dataBarang = snapshot.data;
            return ListView.builder(
              itemCount: dataBarang.length,
              itemBuilder: (context, index) {},
            );
          }
        },
      ),
    );
  }
}

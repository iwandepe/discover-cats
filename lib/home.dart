import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'util.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Image> fetchImage() async {
    var response = await http.get("https://aws.random.cat/meow");

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      return Image.network(jsonMap['file']);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7DFDD),
      body: Center(
        child: FutureBuilder<Image>(
            future: fetchImage(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Image.asset('assets/images/loading.gif');

              return snapshot.data;
            }),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Home()),
          // );
          setState(() {});
        },
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                CustomColors.GreenLight,
                CustomColors.GreenDark,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.GreenShadow,
                blurRadius: 15.0,
                spreadRadius: 7.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Center(
            child: const Text(
              'Discover More',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

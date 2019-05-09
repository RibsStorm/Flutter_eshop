import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../const/my_api.dart';
import '../http/service_main.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postRequest(servicePath['categoryContext']),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
          } else {
            return Center(
              child: SpinKitDoubleBounce(
                color: Colors.blueAccent,
              ),
            );
          }
        });
  }
}

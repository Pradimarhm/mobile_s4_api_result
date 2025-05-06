import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetDetailScreen extends StatefulWidget {
  final int? value;

  const GetDetailScreen({Key? key, this.value}) : super(key: key);

  @override
  _GetDetailScreenState createState() => _GetDetailScreenState(value);
}

class _GetDetailScreenState extends State<GetDetailScreen> {
  final int? _value;
  String? _uri;
  Map? data;

  _GetDetailScreenState(this._value);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final url = "https://reqres.in/api/users/${_value.toString()}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          data = jsonData;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


// class GetDetailScreen extends StatefulWidget {
//   int? value;
//   GetDetailScreen({Key? key, this.value}) : super(key: key);

//   @override
//   _GetDetailScreenState createState() => _GetDetailScreenState(value);
// }

// class _GetDetailScreenState extends State<GetDetailScreen> {
//   int? value;
//   _GetDetailScreenState(this.value);
//   Map? data;
//   String? uri;
  
//   @override
//   void initState() {
//     // TODO: implement initState
//     var url = "https://reqres.in/api/users/${value.toString()}";
//     _getRefreshData(url);

//     print("susu +${value}");
//   }

//   Future<void> _getRefreshData(url) async {
//     getJsonData(context, url);
//   }

//   Future<void> getJsonData(BuildContext context, url) async {
//     setState(() {
//       uri = url;
//     });

//     var response = await http.get(
//       Uri.parse(uri.toString()),
//       headers: {"Accept": "application/json"},
//     );
//     print(reponse.body);
//     setState(() {
//       var convertDataJson = jsonDecode(reponse.body);
//       data = convertDataJson['data'];
//     });
//   }


  @override
  Widget build(BuildContext context) {
    // Use _data to build the widget
    return Scaffold(
      appBar: AppBar(
        title: Text("Get data api regres"),
      ),
      body: Container(
        child: data == null
        ? Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Loading....",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        )
        : Container(
          child: ListTile(
            leading: Image.network(data!["avatar"]),
            title: Text(data!["first_name"] + " " + data!["last_name"]),
            subtitle: Text(data!["email"]),
          ),
        )
      )
    );
  }
}
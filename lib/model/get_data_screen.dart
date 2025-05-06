import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:acarabkpm2/model/get_detail_screen.dart';

class GetDataScreen extends StatefulWidget {
  const GetDataScreen({Key? key}) : super(key: key);

  @override
  _GetDataScreenState createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen> {
  final String url = "https://reqres.in/api/users?page=2";
  List? data;
  @override
  void initState() {
    // TODO: implement initState
    _getRefreshData();
    super.initState();
  }

  Future<void> _getRefreshData() async {
    this.getDataJson(context);
  }

  Future<void> getDataJson(BuildContext context) async {
    final String apiKey = "reqres-free-v1";

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "x-api-key": apiKey,
      },
    );
    print(response.body);
    setState(() {
      var convertDataJson = jsonDecode(response.body);
      data = convertDataJson['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Get data api regres")),
      body: RefreshIndicator(
        onRefresh: _getRefreshData,
        child:
            data == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: data == null ? 0 : data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => GetDetailScreen(
                                        value: data![index]["id"],
                                      ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  ClipRect(
                                    child: Image.network(
                                      data![index]["avatar"],
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        data![index]["first_name"] +
                                            " " +
                                            data![index]["last_name"],
                                      ),
                                      Text(data![index]["email"]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}

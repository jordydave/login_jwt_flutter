import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt/bloc/dashboarduser/dashboard_user_bloc.dart';
import 'package:jwt/injector/injector.dart';
import 'package:jwt/model/dropdown/drop_down.dart';
import 'package:http/http.dart' as http;
import 'package:jwt/storage/sharedpreferences/shared_preferences_manager.dart';

final String apiUrl =
    "https://project.bintorobuild.co.id/api/v2/select_projects";
Future<List<dynamic>> fetchUsers() async {
  var result = await http.get(
    apiUrl,
    headers: {
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'requirestoken': ' true',
      'Authorization': SharedPreferencesManager.keyIsLogin,
    },
  );
  print(SharedPreferencesManager.keyAccessToken);
  print(result.body);
  return json.decode(result.body)['results'];
}

String _id(dynamic user) {
  return user['id'].toString();
}

String _text(dynamic user) {
  return user['text'];
}

class DashboardUserScreen extends StatefulWidget {
  @override
  _DashboardUserScreenState createState() => _DashboardUserScreenState();
}

class _DashboardUserScreenState extends State<DashboardUserScreen> {
  // Future<Project> fetchWelcome() async {
  //   final response = await http.get(
  //     'https://project.bintorobuild.co.id/api/v2/select_projects',
  //     headers: {
  // 'Content-Type': 'application/json',
  // 'Accept': 'application/json',
  //       'Authorization': 'Bearer $SharedPreferencesManager.keyAccessToken',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return Project.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception("Failed");
  //   }
  // }
  // Future<Result> futureData;
  // Future<Project> futureWelcome;
  final DashboardUserBloc _dashboardUserBloc = DashboardUserBloc();

  @override
  void initState() {
    _dashboardUserBloc.add(DashboardUserEvent());
    // futureData = fetchData();
    // getProject();
    // _getResultList();
    super.initState();
    // futureWelcome = fetchWelcome();
  }

  // List resultsList;
  // String _myResult;

  // String resultInfoUrl =
  //     'https://project.bintorobuild.co.id/api/v2/select_projects';
  // Future<String> _getResultList() async {
  //   await http.get(resultInfoUrl, headers: {
  //     'Authorization': '$SharedPreferencesManager.keyAccessToken',
  //   }).then((response) {
  //     var data = json.decode(response.body);
  //     setState(() {
  //       resultsList = data['results'];
  //     });
  //   });
  // }
  // List<Project> projects = List<Project>();
  // Future<List<First>> _getFirst() async {
  //   var data = await http.get(
  //     "https://project.bintorobuild.co.id/api/v2/select_projects",
  //     headers: {
  //       // 'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': '$SharedPreferencesManager.keyAccessToken',
  //     },
  //   );
  //   var jsonData = json.decode(data.body);
  //   List<First> firsts = [];

  //   for (var u in jsonData) {
  //     First first = First(
  //       u["results"],
  //     );
  //     firsts.add(first);
  //   }
  //   print(firsts.length);
  //   return firsts;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.refresh),
            //   onPressed: () {
            //     _dashboardUserBloc.add(DashboardUserEvent());
            //   },
            // ),
            IconButton(
              icon: Icon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                locator<SharedPreferencesManager>().clearAll();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login_screen', (r) => false);
              },
            ),
          ],
        ),
        body:
            // Expanded(
            //   child: DropdownButtonHideUnderline(
            //     child: ButtonTheme(
            //       alignedDropdown: true,
            //       child: DropdownButton<String>(
            //         value: _myResult,
            //         iconSize: 30,
            //         icon: (null),
            //         style: TextStyle(color: Colors.black54, fontSize: 16),
            //         hint: Text("Select Project"),
            //         onChanged: (String newValue) {
            //           setState(() {
            //             _myResult = newValue;
            //             _getResultList();
            //             print(_myResult);
            //           });
            //         },
            //         items: resultsList?.map((item) {
            //               return DropdownMenuItem(
            //                 child: Text(item['text']),
            //                 value: item['id'].toString(),
            //               );
            //             })?.toList() ??
            //             [],
            //       ),
            //     ),
            //   ),
            // ),
            //     FutureBuilder<Project>(
            //   future: futureWelcome,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text(snapshot.data.text);
            //     } else if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }
            //     return CircularProgressIndicator();
            //   },
            // )
            // Text(output),
            // RaisedButton(
            //   onPressed: () {
            //     Project.getProjects("0").then((projects) {
            //       output = "";
            //       for (int i = 0; i < projects.length; i++)
            //         output = output + "[" + projects[i].text + "]";
            //       setState(() {});
            //     });
            //   },
            // )
            //     FutureBuilder<List<Project>>(
            //   future: _fetchProject(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       List<Project> data = snapshot.data;
            //     } else if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }
            //     return CircularProgressIndicator();
            //   },
            // ),
            // );

            //     Center(
            //   child: FutureBuilder<Results>(
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         print("ada data");
            //         return Text(snapshot.data.text);
            //       } else if (snapshot.hasError) {
            //         return Text("${snapshot.error}");
            //       }
            //       print("erorr");
            //       return CircularProgressIndicator();
            //     },
            //   ),
            // ),
            Container(
          child: FutureBuilder<List<dynamic>>(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // print(_id(snapshot.data[0]));
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(_text(snapshot.data[index])),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                print("error");
                return Container();
              }
            },
          ),
        ));
  }
}

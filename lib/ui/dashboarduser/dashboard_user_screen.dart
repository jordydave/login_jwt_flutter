import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt/bloc/dashboarduser/dashboard_user_bloc.dart';
import 'package:jwt/injector/injector.dart';
import 'package:jwt/model/dropdown/drop_down.dart';

import 'package:jwt/storage/sharedpreferences/shared_preferences_manager.dart';

import 'package:http/http.dart' as http;

class DashboardUserScreen extends StatefulWidget {
  @override
  _DashboardUserScreenState createState() => _DashboardUserScreenState();
}

class _DashboardUserScreenState extends State<DashboardUserScreen> {
  Future<Project> fetchWelcome() async {
    final response = await http.get(
      'https://project.bintorobuild.co.id/api/v2/select_projects',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $SharedPreferencesManager.keyAccessToken',
      },
    );
    if (response.statusCode == 200) {
      return Project.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed");
    }
  }

  Future<Project> futureWelcome;
  final DashboardUserBloc _dashboardUserBloc = DashboardUserBloc();

  @override
  void initState() {
    _dashboardUserBloc.add(DashboardUserEvent());

    // getProject();
    // _getResultList();
    super.initState();
    futureWelcome = fetchWelcome();
  }

  List resultsList;
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
  List<Project> projects = List<Project>();

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
            FutureBuilder<Project>(
          future: futureWelcome,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.text);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )
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

        );
  }
}

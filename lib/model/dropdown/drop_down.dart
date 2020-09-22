import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt/storage/sharedpreferences/shared_preferences_manager.dart';

// class Project {
//   String id;
//   String text;

//   Project({this.id, this.text});

//   factory Project.createProject(Map<String, dynamic> object) {
//     return Project(
//       id: object['id'].toString(),
//       text: object['text'],
//     );
//   }

//   static Future<List<Project>> getProjects(String page) async {
//     String apiURL =
//         "https://project.bintorobuild.co.id/api/v2/select_projects?page=" +
//             page;

//     var apiResult = await http.get(
//       apiURL,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $SharedPreferencesManager.keyAccessToken',
//         // HttpHeaders.authorizationHeader:
//         //     "$SharedPreferencesManager.keyAccessToken"
//       },
//     );
//     var jsonObject = json.decode(apiResult.body);
//     List<dynamic> listProject = (jsonObject as Map<String, dynamic>)['results'];

//     List<Project> projects = List<Project>();
//     for (int i = 0; i < listProject.length; i++)
//       projects.add(Project.createProject(listProject[i]));

//     return projects;
//   }
// }

class First {
  final List<Project> results;
  First({this.results});

  factory First.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    print(list.runtimeType);
    List<Project> resultsList = list.map((i) => Project.fromJson(i)).toList();

    return First(
      results: resultsList,
    );
  }
}

class Project {
  final int id;
  final String text;

  Project({
    this.id,
    this.text,
  });

  factory Project.fromJson(Map<String, dynamic> parsedJson) {
    return Project(
      id: parsedJson['id'],
      text: parsedJson['text'],
    );
  }
}

// class Welcome {
//   Welcome({
//     this.results,
//     this.pagination,
//   });

//   List<Result> results;
//   Pagination pagination;

//   factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         results:
//             List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//         pagination: Pagination.fromJson(json["pagination"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//         "pagination": pagination.toJson(),
//       };
// }

// class Pagination {
//   Pagination({
//     this.more,
//   });

//   bool more;

//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         more: json["more"],
//       );

//   Map<String, dynamic> toJson() => {
//         "more": more,
//       };
// }

// class Result {
//   Result({
//     this.id,
//     this.text,
//   });

//   int id;
//   String text;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json["id"],
//         text: json["text"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "text": text,
//       };
// }

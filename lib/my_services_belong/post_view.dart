import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:docx_template/docx_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_derslerim/my_services_belong/post_model.dart';
import 'package:http/http.dart' as http;

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Dio myDio = Dio();

  Future<List<MyPostModel>?> getMyPostWithDio() async {
    final response =
        await myDio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == HttpStatus.ok) {
      var data = response.data;
      if (data is List) {
        return data.map((e) => MyPostModel.fromJson(e)).toList();
      }
    }
    return null;
  }

  Future<List<MyPostModel>?> getMyPostWithHTTP() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == HttpStatus.ok) {
      List decoder = jsonDecode(response.body);
      return decoder.map((e) => MyPostModel.fromJson(e)).toList();
    }
    return null;
  }

  Future<void> postWithDio(MyPostModel data) async {
    final response = await myDio
        .post("https://jsonplaceholder.typicode.com/posts", data: data);
    if (response.statusCode == HttpStatus.created) {
      print("Succes with dio");
    }
  }

  Future<void> postWithHTTP(MyPostModel data) async {
    final response =
        await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
            body: jsonEncode(<String, String>{
              'title': data.title.toString(),
            }));
    if (response.statusCode == HttpStatus.created) {
      print("Succes with http");
    }
  }

  Future<void> DeleteWithHTTP(MyPostModel data) async {
    final response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: data);
    if (response.statusCode == HttpStatus.created) {
      print("Succes with http");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  tryIt.tryWhit();
                  //  postWithHTTP(MyPostModel(    id: 11, body: "123", title: "122", userId: 12));
                },
                icon: const Icon(Icons.send))
          ],
        ),
        body: FutureBuilder<List<MyPostModel>?>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var deger = snapshot.data![index];
                  return ListTile(
                    title: Text(deger.title.toString()),
                    subtitle: Text(deger.body.toString()),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return const Center(
                child: Text("hata"),
              );
            }
          },
          future: getMyPostWithHTTP(),
        ));
  }
}

class tryIt {
  static Future<void> tryWhit() async {
    final f = File(
        '/Users/ahmetbalaman/Desktop/Flutter_Apps/my_flutter_examples/lib/my_services_belong/template.docx');
    final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

    /* 
    Or in the case of Flutter, you can use rootBundle.load, then get bytes
    
    final data = await rootBundle.load('lib/assets/users.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);
  */

    // Load test image for inserting in docx
    final testFileContent = await File(
            '/Users/ahmetbalaman/Desktop/Flutter_Apps/my_flutter_examples/lib/my_services_belong/test.jpg')
        .readAsBytes();

    final listNormal = ['Foo', 'Bar', 'Baz'];
    final listBold = ['ooF', 'raB', 'zaB'];

    final contentList = <Content>[];

    final b = listBold.iterator;
    for (var n in listNormal) {
      b.moveNext();

      final c = PlainContent("value")
        ..add(TextContent("normal", n))
        ..add(TextContent("bold", b.current));
      contentList.add(c);
    }

    Content c = Content();
    c
      ..add(TextContent("docname", "Simple docname"))
      ..add(TextContent("passport", "Passport NE0323 4456673"))
      ..add(TableContent("table", [
        RowContent()
          ..add(TextContent("key1", "Paul"))
          ..add(TextContent("key2", "Viberg"))
          ..add(TextContent("key3", "Engineer"))
          ..add(ImageContent('img', testFileContent)),
        RowContent()
          ..add(TextContent("key1", "Alex"))
          ..add(TextContent("key2", "Houser"))
          ..add(TextContent("key3", "CEO & Founder"))
          ..add(ListContent("tablelist", [
            TextContent("value", "Mercedes-Benz C-Class S205"),
            TextContent("value", "Lexus LX 570")
          ]))
          ..add(ImageContent('img', testFileContent))
      ]))
      ..add(ListContent("list", [
        TextContent("value", "Engine")
          ..add(ListContent("listnested", contentList)),
        TextContent("value", "Gearbox"),
        TextContent("value", "Chassis")
      ]))
      ..add(ListContent("plainlist", [
        PlainContent("plainview")
          ..add(TableContent("table", [
            RowContent()
              ..add(TextContent("key1", "Paul"))
              ..add(TextContent("key2", "Viberg"))
              ..add(TextContent("key3", "Engineer")),
            RowContent()
              ..add(TextContent("key1", "Alex"))
              ..add(TextContent("key2", "Houser"))
              ..add(TextContent("key3", "CEO & Founder"))
              ..add(ListContent("tablelist", [
                TextContent("value", "Mercedes-Benz C-Class S205"),
                TextContent("value", "Lexus LX 570")
              ]))
          ])),
        PlainContent("plainview")
          ..add(TableContent("table", [
            RowContent()
              ..add(TextContent("key1", "Nathan"))
              ..add(TextContent("key2", "Anceaux"))
              ..add(TextContent("key3", "Music artist"))
              ..add(ListContent(
                  "tablelist", [TextContent("value", "Peugeot 508")])),
            RowContent()
              ..add(TextContent("key1", "Louis"))
              ..add(TextContent("key2", "Houplain"))
              ..add(TextContent("key3", "Music artist"))
              ..add(ListContent("tablelist", [
                TextContent("value", "Range Rover Velar"),
                TextContent("value", "Lada Vesta SW Sport")
              ]))
          ])),
      ]))
      ..add(ListContent("multilineList", [
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 1')),
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 2')),
        PlainContent("multilinePlain")
          ..add(TextContent('multilineText', 'line 3'))
      ]))
      ..add(TextContent('multilineText2', 'line 1\nline 2\n line 3'))
      ..add(ImageContent('img', testFileContent));

    final d = await docx.generate(c);
    final of = File(
        '/Users/ahmetbalaman/Desktop/Flutter_Apps/my_flutter_examples/lib/my_services_belong/generated.docx');
    if (d != null) await of.writeAsBytes(d);
  }
}

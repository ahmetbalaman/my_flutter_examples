import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_derslerim/starting_services/post_model.dart';

class ServiceLearnPostView extends StatefulWidget {
  const ServiceLearnPostView({super.key});

  @override
  State<ServiceLearnPostView> createState() => _ServiceLearnPostViewState();
}

class _ServiceLearnPostViewState extends State<ServiceLearnPostView> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late final Dio _dioManager;
  bool? isComplete;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/';
  @override
  void initState() {
    super.initState();
    _dioManager = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> addItem(PostModel model) async {
    changeLoading();
    final response = await _dioManager.post("posts", data: model);

    if (response.statusCode == HttpStatus.created) {
      setState(() {
        isComplete = true;
      });
    }
    changeLoading();
  }

  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isComplete.toString()),
          actions: [
            isLoading
                ? const CircularProgressIndicator.adaptive()
                : const SizedBox.shrink()
          ],
        ),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: _userIdController,
                  decoration: const InputDecoration(label: Text("UserId")),
                  textInputAction: TextInputAction.next,
                  autofillHints: [AutofillHints.creditCardNumber],
                  keyboardType: TextInputType.number,
                  validator: (value) => valueControl(value),
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(label: Text("title")),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) => valueControl(value),
                ),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(label: Text("body")),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: (value) => valueControl(value),
                ),
                TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              PostModel item = PostModel(
                                  title: _titleController.text,
                                  body: _bodyController.text,
                                  userId: int.tryParse(_userIdController.text));
                              addItem(item);
                            } else {}
                          },
                    child: const Text("Post")),
              ],
            )));
  }
}

String? valueControl(value) {
  if (value == null || value.isEmpty) {
    return "Wrong";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_derslerim/starting_services/post_model.dart';
import 'package:flutter_derslerim/starting_services/post_services.dart';

class ServiceLearnPostView extends StatefulWidget {
  const ServiceLearnPostView({super.key});

  @override
  State<ServiceLearnPostView> createState() => _ServiceLearnPostViewState();
}

class _ServiceLearnPostViewState extends State<ServiceLearnPostView> {
  late final PostModelServices servis;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool? isComplete;
  @override
  void initState() {
    super.initState();
    servis = PostModelServices();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _addItem(PostModel item) async {
    changeLoading();
    bool response = await servis.addItem(item) as bool;
    if (response) {
      isComplete = true;
      setState(() {});
    } else {
      isComplete = false;
      setState(() {});
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  PostModel item = PostModel(
                                      title: _titleController.text,
                                      body: _bodyController.text,
                                      userId:
                                          int.tryParse(_userIdController.text));
                                  _addItem(item);
                                } else {}
                              },
                        child: const Text("Post")),
                    TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  PostModel item = PostModel(
                                      title: _titleController.text,
                                      body: _bodyController.text,
                                      userId:
                                          int.tryParse(_userIdController.text));
                                  _addItem(item);
                                } else {}
                              },
                        child: const Text("Update")),
                  ],
                )
              ],
            )));
  }
}

String? valueControl(value) {
  if (value == null || value.isEmpty) {
    return "Wrong";
  }
  return null;
}

import 'package:flutter/material.dart';
import 'package:projblog/service.dart';
import 'person.dart';

// ignore: must_be_immutable
class UpdatePage extends StatefulWidget {
  final Post update;
  VoidCallback? updateui;
  UpdatePage({required this.update, required this.updateui, Key? key})
      : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Update Post'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                      controller: titlecontroller,
                      maxLines: 2,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                      controller: bodycontroller,
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 56.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        widget.update.title = titlecontroller.text;
                        widget.update.body = bodycontroller.text;

                        await api.updatePost(widget.update).then((post) {
                          int index = posts.indexWhere(
                              (element) => element.id == widget.update.id);
                          posts[index] = post;
                          Navigator.of(context).pop();
                          widget.updateui!();
                          setState(() {});
                        });
                      },
                      child: const Text('Update Post'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextEditingController titlecontroller = TextEditingController();
TextEditingController bodycontroller = TextEditingController();
late List<Post> posts;

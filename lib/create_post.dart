import 'package:flutter/material.dart';
import 'package:projblog/person.dart';
import 'package:projblog/service.dart';
import 'package:projblog/update_post.dart';

void main() {}

// ignore: must_be_immutable
class Createpage extends StatefulWidget {
  Post creat;
  VoidCallback updc;
  Createpage({required this.creat, required this.updc, Key? key})
      : super(key: key);

  @override
  _CreatepageState createState() {
    return _CreatepageState();
  }
}

class _CreatepageState extends State<Createpage> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _bodycontroller = TextEditingController();

  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create New Post')),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _titlecontroller,
                decoration: const InputDecoration(
                    hintText: 'Enter new title', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _bodycontroller,
                decoration: const InputDecoration(
                    hintText: 'Enter new body', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  widget.creat.title = _titlecontroller.text;
                  widget.creat.body = _bodycontroller.text;
                  await api
                      .createPost(widget.creat)
                      .then((post) => posts.insert(0, post));

                  widget.updc();
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: const Text('Create Post'),
              ),
            ],
          )),
    );
  }
}

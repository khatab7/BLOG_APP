import 'package:flutter/material.dart';
import 'package:projblog/create_post.dart';
import 'package:projblog/person.dart';
import 'package:projblog/service.dart';
import 'package:projblog/update_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Post? update;
  Post? create;
  late Future<List<Post>> _myposts;
  Api api = Api();
  void updateUi() {
    setState(() {});
  }

  @override
  void initState() {
    _myposts = api.getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Blog App"),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Post>>(
                  future: _myposts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      posts = snapshot.data!;
                      return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            var row = Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    titlecontroller.text = posts[index].title!;
                                    bodycontroller.text = posts[index].body!;
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => UpdatePage(
                                                  update: update = Post(
                                                      id: posts[index].id,
                                                      title: posts[index].title,
                                                      body: posts[index].body,
                                                      userId:
                                                          posts[index].userId),
                                                  updateui: updateUi,
                                                )));
                                    setState(() {});
                                  },
                                  child: const Text('Update'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Delete Post?'),
                                            content:
                                                const Text('Do you Accept?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await api
                                                      .deletPost(
                                                          posts[index].id!)
                                                      .then((post) =>
                                                          posts.remove(
                                                              posts[index]));
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                                child: const Text('Yes'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text('delet'),
                                ),
                              ],
                            );

                            return Column(
                              children: [
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Card(
                                      color: Colors.cyan,
                                      elevation: 26,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Title',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(posts[index].title!),
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(posts[index].body!),
                                            const SizedBox(height: 10.0),
                                            row,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Createpage(
                    creat: create =
                        Post(body: '', id: null, title: '', userId: '1'),
                    updc: updateUi,
                  )));
        },
        child: const Icon(Icons.mail),
      ),
    );
  }
}

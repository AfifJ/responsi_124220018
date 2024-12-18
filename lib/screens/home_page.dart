import 'package:flutter/material.dart';
import 'package:responsi_124220018/screens/list_page.dart';
import 'package:responsi_124220018/screens/login_page.dart';
import 'package:responsi_124220018/services/api_helper.dart';
import 'package:responsi_124220018/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<List<dynamic>> fetchData() async {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Halo " + 'afif'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: ApiHelper.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error : ${snapshot.error}"));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListPage(
                                            category: snapshot.data![index]
                                                ['strCategory'])));
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(
                                      snapshot.data![index]['strCategory']),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
              MaterialButton(
                onPressed: () {
                  AuthService().logout;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                child: Text("Logout"),
              )
            ],
          ),
        ));
  }
}

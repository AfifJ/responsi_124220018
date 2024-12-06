import 'package:flutter/material.dart';
import 'package:responsi_124220018/screens/detail_page.dart';
import 'package:responsi_124220018/services/api_helper.dart';

class ListPage extends StatefulWidget {
  final String category;
  const ListPage({super.key, required this.category});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
                  future: ApiHelper.getMeals(widget.category),
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
                                        builder: (context) => DetailPage(
                                            id: snapshot.data![index]
                                                ['idMeal'])));
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(snapshot.data![index]['strMeal']),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

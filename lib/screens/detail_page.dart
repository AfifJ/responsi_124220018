import 'package:flutter/material.dart';
import 'package:responsi_124220018/services/api_helper.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                child: FutureBuilder<dynamic>(
                  future: ApiHelper.getDetails(widget.id),
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => DetailData(
                                //             title: data[index]['title'],
                                //             newsSite: data[index].newsSite,
                                //             imageUrl: data[index].imageUrl,
                                //             summary: data[index].summary,
                                //             publishedAt:
                                //                 data[index].publishedAt,
                                //             url: data[index].url)));
                              },
                              child: Card(
                                child: Column(children: [
                                  if (index == 0)
                                    Image.network(
                                        snapshot.data![index]['strMealThumb']),
                                  Text(snapshot.data![index]['strMeal']),
                                  Text(
                                      snapshot.data![index]['strInstructions']),
                                ]),
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

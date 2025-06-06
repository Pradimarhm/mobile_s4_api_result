import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'controller/demoController.dart';
import 'view/demoPage.dart';
import 'view/home.dart';
import 'model/get_data_screen.dart';
import 'package:acarabkpm2/data/api_provider.dart';
import 'package:acarabkpm2/model/popular_movies.dart';

void main() async {
  await GetStorage.init();
  runApp(movieApi());
}

class MyApp extends StatelessWidget {
  final DemoController ctrl = Get.put(DemoController());

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          title: 'GetX',
          theme: ctrl.theme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/cart': (context) => DemoPage(),
          },
        );
      },
    );
  }
}

class Apiapps extends StatelessWidget {
  final DemoController ctrl = Get.put(DemoController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetAPI',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: GetDataScreen(),
    );
  }
}

//acara 35//
class movieApi extends StatelessWidget {
  final DemoController ctrl = Get.put(DemoController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiProvider apiProvider = ApiProvider();
  late Future<PopularMovies> popularMovies;

  String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    // TODO: implement initState
    popularMovies = apiProvider.getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: FutureBuilder(
        future: popularMovies,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print("Has Data: ${snapshot.hasData}");
            return ListView.builder(
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return moviesItem(
                  poster:
                      '$imageBaseUrl${snapshot.data.results[index].posterPath}',
                  title: '${snapshot.data.results[index].title}',
                  date: '${snapshot.data.results[index].releaseDate}',
                  voteAverage: '${snapshot.data.results[index].voteAverage}',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MovieDetail(
                        movie: snapshot.data.results[index],
                      ),
                    )); // MovieDetail // MaterialPageRoute
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            print("Has Error: ${snapshot.hasError}");
            return Text('Error!!!');
          } else {
            print("Loading...");
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget moviesItem(
      {required String poster,
      required String title,
      required String date,
      required String voteAverage,
      required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 120,
                  child: CachedNetworkImage(
                    imageUrl: poster,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(date),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(voteAverage),
                          ],
                        )
                      ],
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

class MovieDetail extends StatelessWidget {
  final Results movie;

  const MovieDetail({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ), // AppBar
      body: Container(
        child: Text(movie.overview),
      ), // Container
    ); // Scaffold
  }
}

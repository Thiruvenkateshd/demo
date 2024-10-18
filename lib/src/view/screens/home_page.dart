import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task1/src/view/widgets/vote_counter.dart';

import '../../controller/utils.dart';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse('https://hoblist.com/api/movieList');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "category": "movies",
        "language": "kannada",
        "genre": "all",
        "sort": "voting"
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        movies = data['result'] ?? [];
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        automaticallyImplyLeading: false,
      ),
      body: movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index];
                String title = movie['title'] ?? '';
                String genre = movie['genre'] ?? '';
                String director =
                    movie['director'] != null && movie['director'].isNotEmpty
                        ? movie['director'][0]
                        : 'N/A';
                String starring =
                    movie['stars'] != null && movie['stars'].isNotEmpty
                        ? movie['stars'][0]
                        : 'N/A';
                int pageViews = movie['pageViews'] ?? 0;
                int voting = movie['voting'] ?? 0;
                String posterUrl = movie['poster'] ?? '';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                VoteCounter(count: voting),
                                Text("Votes")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              posterUrl,
                              height: 150,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 150,
                                  width: 100,
                                  color: Colors.grey,
                                  child: Icon(Icons.image, color: Colors.white),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Genre: $genre',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Director: $director',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Starring: $starring',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '$pageViews views|Voted by $voting people',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: screenWidth,
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue),
                          child: Text(
                            "Watch Later",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewsWidget extends StatelessWidget {
  final int productId;

  const ReviewsWidget({Key? key, required this.productId}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchReviews() async {
    final url = Uri.parse('https://dummyjson.com/products/$productId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> reviews = data['reviews'];
      return reviews.map((review) => {
            'reviewerName': review['reviewerName'],
            'comment': review['comment'],
            'rating': review['rating'],
          }).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading reviews'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final reviews = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Reviews",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              review['reviewerName'][0],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['reviewerName'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  review['comment'],
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: List.generate(
                                    review['rating'],
                                    (index) => Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          return Center(child: Text('No reviews available'));
        }
      },
    );
  }
}

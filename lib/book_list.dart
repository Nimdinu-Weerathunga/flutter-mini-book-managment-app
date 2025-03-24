import 'package:flutter/material.dart';
import 'book_model.dart';
import 'book_details.dart';

class BookListPage extends StatelessWidget {
  final List<Book> books;

  const BookListPage({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Book Descriptions")),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text(books[index].description),
              subtitle: Text("Added on: ${books[index].date}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsPage(book: books[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

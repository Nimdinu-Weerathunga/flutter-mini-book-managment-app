import 'package:flutter/material.dart';
import 'book_list.dart';
import 'book_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Book> books = []; // Stores book descriptions
  final TextEditingController _controller = TextEditingController();

  void _addBook() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        books.insert(
            0, Book(description: _controller.text, date: DateTime.now()));
        _controller.clear();
      });
    }
  }

  void _goToBookList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookListPage(books: books)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Management"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _goToBookList, // Navigate to full book list
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("User ID: 001",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Name: John Doe"),
                  Text("Address: 123 Book Street"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (books.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Latest Entry: ${books.first.description}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),

            Expanded(
              child: books.length > 1
                  ? ListView.builder(
                      itemCount: books.length - 1, // Exclude latest entry
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(books[index + 1].description),
                            subtitle: Text(
                              "Added on: ${books[index + 1].date}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("No previous entries.")),
            ),

            // 📌 Input Field & Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter Book Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addBook,
                  child: const Text("📌Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

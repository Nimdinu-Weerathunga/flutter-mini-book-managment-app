import 'package:flutter/material.dart';
import 'book_list.dart';
import 'book_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Book> books = [];
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("📚 Book Manager"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'View Book List',
            onPressed: _goToBookList,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 User Info Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("User ID: 001",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text("Name: John Doe", style: TextStyle(fontSize: 14)),
                    Text("Address: 123 Book Street",
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔸 Latest Entry
            if (books.isNotEmpty)
              Card(
                color: Colors.orange.shade100,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.bookmark, color: Colors.orange),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Latest Entry: ${books.first.description}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // 🟡 List of Previous Entries
            Expanded(
              child: books.length > 1
                  ? ListView.separated(
                      itemCount: books.length - 1,
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final book = books[index + 1];
                        return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: Text(book.description,
                                style: const TextStyle(fontSize: 16)),
                            subtitle: Text(
                              "Added on: ${book.date.toLocal().toString().split(' ')[0]}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            leading: const Icon(Icons.menu_book),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("No previous entries.")),
            ),

            const SizedBox(height: 16),

            // 🔘 Input + Add Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter Book Description",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _addBook,
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

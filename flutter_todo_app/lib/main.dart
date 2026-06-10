import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF3C623),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8E86D),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? const Color(0xFF2E2E2E)
                : Colors.transparent,
          ),
          side: const BorderSide(color: Color(0xFF2E2E2E), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
      ),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<_TodoItem> _items = [
    _TodoItem('Make Tutorial'),
    _TodoItem('Do Exercise', isDone: true),
    _TodoItem(' '),
    _TodoItem('Code app'),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleItem(int index, bool? value) {
    setState(() {
      _items[index].isDone = value ?? false;
    });
  }

  void _showAddTaskDialog() {
    _controller.clear();
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFBEA74),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Add Task'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Type a new task',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isEmpty) {
                  return;
                }

                setState(() {
                  _items.add(_TodoItem(text));
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E2E),
                foregroundColor: Colors.white,
              ),
              child: const Text('ADD'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8E86D), Color(0xFFE7D879)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'TO DO',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4D4D4D),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 96),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Container(
                      height: 76,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9DE3A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 1.1,
                            child: Checkbox(
                              value: item.isDone,
                              onChanged: (value) => _toggleItem(index, value),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color(0xFF4D4D4D),
                                decoration: item.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _items.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete_outline),
                            color: const Color(0xFF4D4D4D),
                            tooltip: 'Delete todo',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFFF0D31A),
        foregroundColor: const Color(0xFF4D4D4D),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TodoItem {
  _TodoItem(this.title, {this.isDone = false});

  final String title;
  bool isDone;
}

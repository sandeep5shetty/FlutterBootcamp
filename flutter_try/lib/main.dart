import 'package:flutter/material.dart';

const String _profileImageAsset = 'assets/sandeep.jpeg';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Section',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF202124),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD54F),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int auraPoints = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202124),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2B2F),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile Section',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            auraPoints++;
          });
        },
        backgroundColor: const Color(0xFFFFD54F),
        foregroundColor: const Color(0xFF202124),
        child: const Icon(Icons.directions_run_rounded, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      _profileImageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 48,
                          color: Color(0xFFDBB58A),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Divider(color: Colors.grey.shade700, thickness: 0.8, height: 0),
              const SizedBox(height: 28),
              Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sandeep Shetty',
                style: TextStyle(
                  color: Color(0xFFFFD54F),
                  letterSpacing: 1.5,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Current Aura Points ',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  letterSpacing: 1.4,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$auraPoints',
                style: TextStyle(
                  color: Color(0xFFFFD54F),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.language, color: Colors.grey, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'sandeepshetty.dev',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

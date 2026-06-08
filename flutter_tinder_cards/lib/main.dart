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
      title: 'Tinder Cards',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F6B8A)),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: Color(0xFF243746),
          ),
          headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF243746),
          ),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF5E6C78)),
        ),
      ),
      home: const TinderCardsPage(),
    );
  }
}

class TinderCardsPage extends StatefulWidget {
  const TinderCardsPage({super.key});

  @override
  State<TinderCardsPage> createState() => _TinderCardsPageState();
}

class _TinderCardsPageState extends State<TinderCardsPage> {
  final List<CardProfile> _profiles = const [
    CardProfile(
      name: 'Alexa',
      age: 24,
      color: Color(0xFF3B82B8),
      caption: 'Loves coffee, road trips, and good music.',
    ),
    CardProfile(
      name: 'Mia',
      age: 26,
      color: Color(0xFF6C8FAF),
      caption: 'Always up for a weekend hike or a movie night.',
    ),
    CardProfile(
      name: 'Noah',
      age: 25,
      color: Color(0xFF4F7C9B),
      caption: 'Foodie, traveler, and beginner photographer.',
    ),
  ];

  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;

  void _swipeCard(bool like) {
    setState(() {
      if (_currentIndex < _profiles.length - 1) {
        _currentIndex += 1;
      }
      _dragOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = _profiles[_currentIndex % _profiles.length];
    final nextProfile = _profiles[(_currentIndex + 1) % _profiles.length];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2F6B8A),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.dashboard_customize_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Tinder Cards',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final cardHeight = constraints.maxHeight * 0.72;
                    final cardWidth = constraints.maxWidth;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 22,
                          child: Opacity(
                            opacity: 0.9,
                            child: Transform.scale(
                              scale: 0.94,
                              child: _ProfileCard(
                                profile: nextProfile,
                                height: cardHeight,
                                width: cardWidth,
                                isBackground: true,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              _dragOffset += details.delta;
                            });
                          },
                          onPanEnd: (_) {
                            if (_dragOffset.dx.abs() > 120) {
                              _swipeCard(_dragOffset.dx > 0);
                            } else {
                              setState(() {
                                _dragOffset = Offset.zero;
                              });
                            }
                          },
                          child: Transform.translate(
                            offset: _dragOffset,
                            child: Transform.rotate(
                              angle: _dragOffset.dx / 500,
                              child: _ProfileCard(
                                profile: currentProfile,
                                height: cardHeight,
                                width: cardWidth,
                                showLabels: true,
                                likeOpacity: (_dragOffset.dx / 150).clamp(
                                  0.0,
                                  1.0,
                                ),
                                nopeOpacity: (-_dragOffset.dx / 150).clamp(
                                  0.0,
                                  1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Try swiping the top card left or right, or use the buttons below.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.close,
                    color: const Color(0xFFE25C72),
                    onPressed: () => _swipeCard(false),
                  ),
                  _ActionButton(
                    icon: Icons.play_arrow_rounded,
                    color: const Color(0xFF6BBF59),
                    onPressed: () => _swipeCard(true),
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

class CardProfile {
  const CardProfile({
    required this.name,
    required this.age,
    required this.color,
    required this.caption,
  });

  final String name;
  final int age;
  final Color color;
  final String caption;
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.profile,
    required this.height,
    required this.width,
    this.isBackground = false,
    this.showLabels = false,
    this.likeOpacity = 0,
    this.nopeOpacity = 0,
  });

  final CardProfile profile;
  final double height;
  final double width;
  final bool isBackground;
  final bool showLabels;
  final double likeOpacity;
  final double nopeOpacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              profile.color,
              Color.fromARGB(
                (profile.color.a * 255).round().clamp(0, 255),
                (profile.color.r * 255).round().clamp(0, 255),
                (profile.color.g * 255).round().clamp(0, 255),
                ((profile.color.b * 255) + 30).round().clamp(0, 255),
              ),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isBackground ? 0.12 : 0.18),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.black.withValues(alpha: 0.18),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 24,
                right: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Badge(
                      text: 'NOPE',
                      color: Colors.redAccent,
                      opacity: nopeOpacity,
                    ),
                    _Badge(
                      text: 'LIKE',
                      color: Colors.greenAccent,
                      opacity: likeOpacity,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${profile.name}, ${profile.age}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      profile.caption,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    if (showLabels) ...[
                      const SizedBox(height: 28),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 28),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (showLabels)
                Positioned(
                  bottom: 110,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 62,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.text,
    required this.color,
    required this.opacity,
  });

  final String text;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 34),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationShowcaseApp());
}

class AnimationShowcaseApp extends StatelessWidget {
  const AnimationShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF7C5CFC),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const AnimationShowcasePage(),
    );
  }
}

class AnimationShowcasePage extends StatefulWidget {
  const AnimationShowcasePage({super.key});

  @override
  State<AnimationShowcasePage> createState() => _AnimationShowcasePageState();
}

class _AnimationShowcasePageState extends State<AnimationShowcasePage>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _pulseController;
  late AnimationController _spinController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _pulseController.dispose();
    _spinController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Showcase'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Custom Animations',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildAnimationCard(
            'Bounce',
            'Elastic easing with overshoot',
            AnimatedBuilder(
              animation: _bounceController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * Curves.elasticOut.transform(_bounceController.value)),
                  child: child,
                );
              },
              child: const Icon(Icons.arrow_upward, size: 48, color: Color(0xFF7C5CFC)),
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimationCard(
            'Pulse',
            'Scale animation with glow effect',
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale = 1.0 + 0.2 * _pulseController.value;
                return Transform.scale(scale: scale, child: child);
              },
              child: const Icon(Icons.favorite, size: 48, color: Color(0xFFFC5C8C)),
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimationCard(
            'Spin',
            'Continuous 360° rotation',
            AnimatedBuilder(
              animation: _spinController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _spinController.value * 2 * 3.14159,
                  child: child,
                );
              },
              child: const Icon(Icons.settings, size: 48, color: Color(0xFF5CFCB6)),
            ),
          ),
          const SizedBox(height: 16),
          _buildAnimationCard(
            'Slide & Scale',
            'Combined translate and scale transforms',
            AnimatedBuilder(
              animation: _slideController,
              builder: (context, child) {
                final dx = 30 * (2 * _slideController.value - 1);
                final scale = 1.0 + 0.15 * _slideController.value;
                return Transform(
                  transform: Matrix4.identity()
                    ..translate(dx)
                    ..scale(scale),
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: const Icon(Icons.swap_horiz, size: 48, color: Color(0xFFFCB85C)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationCard(String title, String subtitle, Widget animation) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withOpacity(0.06)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            SizedBox(width: 80, height: 80, child: Center(child: animation)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

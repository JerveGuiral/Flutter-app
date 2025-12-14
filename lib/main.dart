import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firestore_service.dart';

import 'dart:developer' as devtools;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class AppClass {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const AppClass({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

final List<AppClass> appClasses = [
  AppClass(
    id: '0',
    name: 'Spotify',
    description: 'Music and podcast streaming platform',
    icon: Icons.music_note,
    color: Colors.green,
  ),
  AppClass(
    id: '1',
    name: 'Facebook',
    description: 'Social networking and messaging platform',
    icon: Icons.people,
    color: Colors.blue,
  ),
  AppClass(
    id: '2',
    name: 'Instagram',
    description: 'Photo and video sharing social media',
    icon: Icons.camera_alt,
    color: Colors.pink,
  ),
  AppClass(
    id: '3',
    name: 'X',
    description: 'Social media and news platform',
    icon: Icons.forum,
    color: Colors.black,
  ),
  AppClass(
    id: '4',
    name: 'Shopee',
    description: 'E-commerce and shopping platform',
    icon: Icons.shopping_bag,
    color: Colors.red,
  ),
  AppClass(
    id: '5',
    name: 'Lazada',
    description: 'Online shopping and marketplace',
    icon: Icons.store,
    color: Colors.blue,
  ),
  AppClass(
    id: '6',
    name: 'Youtube',
    description: 'Video streaming and sharing platform',
    icon: Icons.play_circle,
    color: Colors.red,
  ),
  AppClass(
    id: '7',
    name: 'Tik-tok',
    description: 'Short-form video social media app',
    icon: Icons.theaters,
    color: Colors.cyan,
  ),
  AppClass(
    id: '8',
    name: 'G-cash',
    description: 'Mobile payment and financial services',
    icon: Icons.wallet_outlined,
    color: Colors.indigo,
  ),
  AppClass(
    id: '9',
    name: 'Snapchat',
    description: 'Photo and message sharing social app',
    icon: Icons.photo_camera,
    color: Colors.yellow,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Identifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          const IdentifierScreen(),
          const HistoryScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Identify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade50, Colors.blue.shade50],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.deepPurple.shade500,
                        Colors.blue.shade400,
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'App Classifier',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore All Categories',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: appClasses.length,
                itemBuilder: (context, index) {
                  final appClass = appClasses[index];
                  return AppClassCard(appClass: appClass, index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppClassCard extends StatefulWidget {
  final AppClass appClass;
  final int index;

  const AppClassCard({
    super.key,
    required this.appClass,
    required this.index,
  });

  @override
  State<AppClassCard> createState() => _AppClassCardState();
}

class _AppClassCardState extends State<AppClassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(Duration(milliseconds: widget.index * 50), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 12,
          shadowColor: widget.appClass.color.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.appClass.color.withOpacity(0.15),
                  widget.appClass.color.withOpacity(0.05),
                ],
              ),
              border: Border.all(
                color: widget.appClass.color.withOpacity(0.25),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.appClass.color.withOpacity(0.25),
                        widget.appClass.color.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: widget.appClass.color.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.appClass.icon,
                    size: 40,
                    color: widget.appClass.color,
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.appClass.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                      letterSpacing: 0.4,
                    ),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.appClass.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IdentifierScreen extends StatefulWidget {
  const IdentifierScreen({super.key});

  @override
  State<IdentifierScreen> createState() => _IdentifierScreenState();
}

class _IdentifierScreenState extends State<IdentifierScreen> {
  File? filePath;
  String? label;
  double? accuracy;
  bool isLoading = false;
  String? errorMessage;
  bool modelLoaded = false;
  static const platform = MethodChannel('com.example.first_app/tflite');

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      await platform.invokeMethod('loadModel');
      setState(() {
        modelLoaded = true;
      });
      devtools.log("Model loaded successfully");
    } catch (e) {
      devtools.log("Error loading model: $e");
      if (mounted) {
        setState(() {
          errorMessage = "Failed to load model: $e";
        });
      }
    }
  }

  Future<void> _runInference(String imagePath) async {
    if (!modelLoaded) {
      if (mounted) {
        setState(() {
          errorMessage = "Model is still loading...";
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
    }

    try {
      final result = await platform.invokeMethod('runInference', {
        'imagePath': imagePath,
      });

      String predictedLabel = result['label'] as String;
      double confidence = (result['confidence'] as num).toDouble();

      devtools.log("Prediction: $predictedLabel with confidence: $confidence");

      if (mounted) {
        setState(() {
          label = predictedLabel;
          accuracy = confidence;
          isLoading = false;
        });
      }

      FirestoreService.savePrediction(
        label: predictedLabel,
        confidence: confidence,
        timestamp: DateTime.now().toIso8601String(),
      ).then((_) {
        devtools.log("Successfully saved to Firestore!");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved to Firestore!'),
            duration: Duration(seconds: 2),
          ),
        );
      }).catchError((e) {
        devtools.log("Error saving to Firestore: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      });
    } catch (e) {
      devtools.log("Error running inference: $e");
      if (mounted) {
        setState(() {
          errorMessage = "Error: ${e.toString()}";
          isLoading = false;
        });
      }
    }
  }

  Future<void> pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    if (mounted) {
      setState(() {
        filePath = File(image.path);
      });
    }

    await _runInference(image.path);
  }

  Future<void> pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    if (mounted) {
      setState(() {
        filePath = File(image.path);
      });
    }

    await _runInference(image.path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade50, Colors.blue.shade50],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'App Identifier',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.deepPurple.shade700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Take a photo or upload to identify',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 12,
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepPurple.shade100.withOpacity(0.5),
                            Colors.blue.shade100.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            height: 280,
                            width: 280,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: filePath == null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Icon(
                                            Icons.image_outlined,
                                            size: 48,
                                            color:
                                                Colors.deepPurple.shade300,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No image selected',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap a button below to start',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      filePath!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 28),
                          if (isLoading)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        Colors.deepPurple.shade400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Analyzing image...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.deepPurple.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else if (errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red.shade600,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        errorMessage!,
                                        style: TextStyle(
                                          color: Colors.red.shade700,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (label != null && accuracy != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Column(
                                children: [
                                  Text(
                                    'IDENTIFIED APP',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    label!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.deepPurple.shade600,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          _getAccuracyColor(accuracy!)
                                              .withOpacity(0.12),
                                          _getAccuracyColor(accuracy!)
                                              .withOpacity(0.04),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _getAccuracyColor(accuracy!)
                                            .withOpacity(0.35),
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'CONFIDENCE',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${(accuracy! * 100).toStringAsFixed(1)}%',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w900,
                                            color: _getAccuracyColor(accuracy!),
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: LinearProgressIndicator(
                                            value: accuracy!,
                                            minHeight: 10,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              _getAccuracyColor(accuracy!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(
                        onPressed: isLoading ? null : pickImageCamera,
                        icon: Icons.camera_alt_outlined,
                        label: 'Camera',
                        isLoading: isLoading,
                      ),
                      const SizedBox(width: 16),
                      _buildActionButton(
                        onPressed: isLoading ? null : pickImageGallery,
                        icon: Icons.image_outlined,
                        label: 'Gallery',
                        isPrimary: true,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    bool isPrimary = false,
    required bool isLoading,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isPrimary
              ? Colors.deepPurple.shade600
              : Colors.blue.shade500,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade400,
          disabledForegroundColor: Colors.white70,
          elevation: isPrimary ? 8 : 6,
          shadowColor: isPrimary
              ? Colors.deepPurple.withOpacity(0.5)
              : Colors.blue.withOpacity(0.5),
        ),
      ),
    );
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 0.9) {
      return Colors.green;
    } else if (accuracy >= 0.7) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade50, Colors.blue.shade50],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              expandedHeight: 140,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.deepPurple.shade500,
                        Colors.blue.shade400,
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'History',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'All Your Identifications',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: StreamBuilder(
                stream: FirestoreService.getPredictions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple.shade400,
                          ),
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.history,
                                size: 48,
                                color: Colors.deepPurple.shade300,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No history yet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Identify an app to start building history',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;
                  return SliverList.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index];
                      final label = data['label'] as String;
                      final confidence = (data['confidence'] as num).toDouble();
                      final timestamp = data['timestamp'] as String?;

                      return Card(
                        elevation: 6,
                        margin: const EdgeInsets.only(bottom: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.deepPurple.withOpacity(0.06),
                                Colors.blue.withOpacity(0.04),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        label,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.deepPurple.shade600,
                                          letterSpacing: 0.3,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            _getConfidenceColor(confidence)
                                                .withOpacity(0.15),
                                            _getConfidenceColor(confidence)
                                                .withOpacity(0.05),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: _getConfidenceColor(confidence)
                                              .withOpacity(0.35),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        '${(confidence * 100).toStringAsFixed(1)}%',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              _getConfidenceColor(confidence),
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: confidence,
                                    minHeight: 8,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getConfidenceColor(confidence),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (timestamp != null)
                                  Text(
                                    timestamp,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.9) {
      return Colors.green;
    } else if (confidence >= 0.7) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

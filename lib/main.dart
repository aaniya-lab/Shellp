import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/new_request_dialog.dart';
import 'features/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // TO DO: Replace these placeholders with your actual Firebase Web Config keys!
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
    ),
  );
  runApp(const ShellpApp());
}

class ShellpApp extends StatelessWidget {
  const ShellpApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shellp',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE03A3E),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE03A3E)),
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;
        return Scaffold(
          floatingActionButtonLocation: isMobile ? FloatingActionButtonLocation.centerFloat : FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 35 : 0),
            child: HoverScale(
              onTap: () async {
                final newPost = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => const NewRequestDialog(),
                );
                if (newPost != null) {
                  // BACKEND: Add new post to Firestore
                  await FirebaseFirestore.instance.collection('requests').add({
                    'tag': newPost['tag'],
                    'tagColor': 0xFF000000, // Defaulting to black for now
                    'scutes': newPost['scutes'],
                    'title': newPost['title'],
                    'description': newPost['description'],
                    'userInitial': 'T',
                    'timestamp': FieldValue.serverTimestamp(),
                  });
                }
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFE03A3E),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
          body: Column(
            children: [
              // Top colorful strip
              Row(
                children: [
                  Expanded(child: Container(height: 12, color: const Color(0xFFE03A3E))),
                  Expanded(child: Container(height: 12, color: const Color(0xFFFFD200))),
                  Expanded(child: Container(height: 12, color: Colors.black)),
                  Expanded(child: Container(height: 12, color: const Color(0xFFE03A3E))),
                ],
              ),
              // App Bar Area
              Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 20),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SHELLP', style: TextStyle(color: Color(0xFFE03A3E), fontSize: 48, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, letterSpacing: -1.5)),
                        if (!isMobile) const Text('TERPS FOR TRADE: NO SHELLS ATTACHED', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        if (!isMobile) ...[
                          // BACKEND: Live Balance Stream
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.collection('users').doc('user1').snapshots(),
                            builder: (context, snapshot) {
                              int balance = 0;
                              if (snapshot.hasData && snapshot.data!.exists) {
                                var data = snapshot.data!.data() as Map<String, dynamic>;
                                balance = data['credits'] ?? 0;
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('YOUR BALANCE', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    color: const Color(0xFFFFD200),
                                    child: Text('$balance SCUTES', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                        ],
                        HoverScale(
                          onTap: () => setState(() => _selectedTabIndex = 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            color: Colors.black,
                            child: const Text('THE NEST', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Main Content Area
              Expanded(
                child: Row(
                  children: [
                    if (!isMobile)
                      Container(
                        width: 250,
                        decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black, width: 2))),
                        child: _buildProfileContent(isMobile: false),
                      ),
                    Expanded(
                      child: _selectedTabIndex == 1 
                        ? SingleChildScrollView(child: _buildProfileContent(isMobile: isMobile))
                        : StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                              var docs = snapshot.data!.docs;
                              return ListView.separated(
                                padding: EdgeInsets.all(isMobile ? 20 : 40),
                                itemCount: docs.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 30),
                                itemBuilder: (context, index) {
                                  var post = docs[index].data() as Map<String, dynamic>;
                                  return _buildRequestCard(
                                    tag: post['tag'] ?? 'ALL',
                                    tagColor: Color(post['tagColor'] ?? 0xFF000000),
                                    scutes: post['scutes'] ?? 0,
                                    title: post['title'] ?? '',
                                    description: post['description'] ?? '',
                                    userInitial: post['userInitial'] ?? 'T',
                                    timeAgo: 'Now',
                                    isMobile: isMobile,
                                  );
                                },
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
              if (isMobile) _buildMobileBottomNavArea(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120, height: 120,
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.black, boxShadow: const [BoxShadow(color: Color(0xFFFFD200), offset: Offset(6, 6))]),
          child: const Icon(Icons.sentiment_very_satisfied, size: 80, color: Colors.white),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text('TESTUDO', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
        ),
      ],
    );
  }

  Widget _buildRequestCard({required String tag, required Color tagColor, required int scutes, required String title, required String description, required String userInitial, required String timeAgo, bool isMobile = false}) {
    return HoverCard(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), color: tagColor, child: Text(tag, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 10))),
                Text('$scutes SCUTES', style: const TextStyle(color: Color(0xFFE03A3E), fontWeight: FontWeight.w900, fontSize: 24, fontStyle: FontStyle.italic)),
              ],
            ),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
            const SizedBox(height: 30),
            const Divider(color: Colors.black, thickness: 1),
            Row(
              children: [
                const Text('BY: ', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: Colors.grey)),
                Text(userInitial, style: const TextStyle(fontWeight: FontWeight.w900)),
                const Spacer(),
                HoverScale(
                  onTap: () async {
                    // Logic for "Giving Shellp"
                    await FirebaseFirestore.instance.collection('users').doc('user1').update({'credits': FieldValue.increment(scutes)});
                  },
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), color: Colors.black, child: const Text('GIVE SHELLP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMobileBottomNavArea() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.black, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: const Icon(Icons.grid_view), onPressed: () => setState(() => _selectedTabIndex = 0)),
          const SizedBox(width: 40),
          IconButton(icon: const Icon(Icons.people_outline), onPressed: () => setState(() => _selectedTabIndex = 1)),
        ],
      ),
    );
  }
}

// Reuse your HoverScale and HoverCard classes here...
class HoverScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  const HoverScale({super.key, required this.child, this.onTap, this.scale = 1.05});
  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(scale: _isHovered ? widget.scale : 1.0, duration: const Duration(milliseconds: 150), child: widget.child),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  const HoverCard({super.key, required this.child});
  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [BoxShadow(color: _isHovered ? const Color(0xFFE03A3E) : Colors.black, offset: const Offset(8, 8))],
        ),
        child: widget.child,
      ),
    );
  }
}
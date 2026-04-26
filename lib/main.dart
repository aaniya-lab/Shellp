import 'package:flutter/material.dart';

void main() => runApp(const ShellpApp());

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
        fontFamily: 'Roboto', // Default font family
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Stack(
            children: [
              Column(
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
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'SHELLP',
                              style: TextStyle(
                                color: Color(0xFFE03A3E),
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                letterSpacing: -1.5,
                              ),
                            ),
                            if (!isMobile) ...[
                              const SizedBox(height: 4),
                              const Text(
                                'TERPS FOR TRADE: NO SHELLS ATTACHED',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3,
                                  fontSize: 10,
                                ),
                              ),
                            ]
                          ],
                        ),
                        // Right Side
                        Row(
                          children: [
                            if (!isMobile) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('YOUR BALANCE', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    color: const Color(0xFFFFD200),
                                    child: const Text(
                                      '20 SCUTES',
                                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                            ],
                            HoverScale(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                color: Colors.black,
                                child: Row(
                                  children: [
                                    if (!isMobile) ...[
                                      const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.person, size: 16, color: Colors.black),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                    const Text(
                                      'THE NEST',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Filters
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 15),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.grid_view, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          const Text('FILTERS:', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey, fontSize: 12)),
                          const SizedBox(width: 20),
                          _buildFilterItem('ALL', true),
                          _buildFilterItem('TECH & DEV', false),
                          _buildFilterItem('MISCELLANEOUS', false),
                          _buildFilterItem('CREATIVE ARTS', false),
                          _buildFilterItem('PROFESSIONALISM', false),
                        ],
                      ),
                    ),
                  ),
                  if (isMobile)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black, width: 2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'THE SHELLP-FEED',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
                          ),
                          Row(
                            children: [
                              _buildFeedTab('NEWEST', true),
                              const SizedBox(width: 15),
                              _buildFeedTab('NEAR ME', false),
                            ],
                          )
                        ],
                      ),
                    ),
                  // Main Content
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile)
                          // Left Sidebar
                          Container(
                            width: 250,
                            decoration: const BoxDecoration(
                              border: Border(right: BorderSide(color: Colors.black, width: 2)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Profile Pic Placeholder
                                        Container(
                                          width: 100,
                                          height: 100,
                                          margin: const EdgeInsets.only(left: 30, top: 30, bottom: 20),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFD200),
                                            border: Border.all(color: Colors.black, width: 2),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.sentiment_very_satisfied, size: 60, color: Colors.black54),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text('TESTUDO', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                                              const Text('JUNIOR @ CLARK SCHOOL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.grey)),
                                              const SizedBox(height: 30),
                                              const Text('SKILLS I HAVE', style: TextStyle(color: Color(0xFFE03A3E), fontWeight: FontWeight.w900, fontSize: 12)),
                                              const SizedBox(height: 10),
                                              _buildSkillChip('History of UMD'),
                                              _buildSkillChip('Spirit Leadership'),
                                              _buildSkillChip('Shell Polishing'),
                                              const SizedBox(height: 20),
                                              const Text('SKILLS I NEED', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 12)),
                                              const SizedBox(height: 10),
                                              _buildSkillChip('React Development', italic: true),
                                              _buildSkillChip('Car Maintenance', italic: true),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _buildSidebarMenu('MY SHELLP-MATES (12)'),
                                _buildSidebarMenu('SCUTE HISTORY'),
                                _buildSidebarMenu('SETTINGS'),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        // Feed Area
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(isMobile ? 20 : 40),
                            children: [
                              _buildRequestCard(
                                tag: 'TECH & DEV',
                                tagColor: Colors.black,
                                scutes: 2,
                                title: 'NEED HELP CLEANING UP MY GITHUB PROFILE',
                                description: 'LOOKING FOR SOMEONE TO HELP ME ORGANIZE MY REPOS AND WRITE A BETTER README FOR MY PORTFOLIO.',
                                userInitial: '2',
                                timeAgo: '2h ago',
                                isMobile: isMobile,
                              ),
                              const SizedBox(height: 30),
                              _buildRequestCard(
                                tag: 'CREATIVE ARTS',
                                tagColor: Colors.blue,
                                scutes: 1,
                                title: 'LINKEDIN HEADSHOTS HELP!',
                                description: 'WILL SWAP 1 HOUR OF REACT HELP FOR A LINKEDIN HEADSHOT. I HAVE A NICE CAMERA BUT NEED SOMEONE TO TAKE THE PHOTOS.',
                                userInitial: '1',
                                timeAgo: '1d ago',
                                isMobile: isMobile,
                              ),
                              if (isMobile) const SizedBox(height: 100), // Padding for FAB
                            ],
                          ),
                        ),
                        if (!isMobile)
                          // Right Sidebar
                          Container(
                            width: 300,
                            color: Colors.black,
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHashtag('#RESUMES', '10 ACTIVE REQUESTS'),
                                _buildHashtag('#TAXES2024', '15 ACTIVE REQUESTS'),
                                _buildHashtag('#RASPBERRYPI', '20 ACTIVE REQUESTS'),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.privacy_tip_outlined, color: Color(0xFFE03A3E), size: 20),
                                          const SizedBox(width: 8),
                                          const Text('LEGAL SHELL-CLAIMER', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'SHELLP USERS ARE PEERS, NOT PROS. INFORMATION PROVIDED IS FOR EDUCATIONAL PURPOSES. TRADE AT YOUR OWN RISK!',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Bottom Bar
                  if (isMobile)
                    _buildMobileBottomNavArea()
                  else
                    Container(
                      color: Colors.black,
                      child: Column(
                        children: [
                          Container(height: 4, color: const Color(0xFFFFD200)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildFooterText('• JOIN THE COLONY'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• EARN YOUR SCUTES'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• TERPS TRADE TALENTS'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• NO SHELLS ATTACHED'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• JOIN THE COLONY'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• EARN YOUR SCUTES'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• TERPS TRADE TALENTS'),
                                  const SizedBox(width: 30),
                                  _buildFooterText('• NO SHELLS ATTACHED'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (isMobile)
                Positioned(
                  bottom: 35, // Floats above ticker and bottom nav
                  left: 0,
                  right: 0,
                  child: Center(
                    child: HoverScale(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE03A3E),
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, offset: Offset(4, 4)),
                          ],
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMobileBottomNavArea() {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black, width: 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HoverScale(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.grid_view, color: Color(0xFFE03A3E)),
                    const SizedBox(height: 4),
                    const Text('FEED', style: TextStyle(color: Color(0xFFE03A3E), fontSize: 10, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              const SizedBox(width: 60), // Space for FAB
              HoverScale(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.people_outline, color: Colors.black),
                    const SizedBox(height: 4),
                    const Text('NEST', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Bottom Bar Ticker
        Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(height: 4, color: const Color(0xFFFFD200)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFooterText('• JOIN THE COLONY'),
                      const SizedBox(width: 30),
                      _buildFooterText('• EARN YOUR SCUTES'),
                      const SizedBox(width: 30),
                      _buildFooterText('• TERPS TRADE TALENTS'),
                      const SizedBox(width: 30),
                      _buildFooterText('• NO SHELLS ATTACHED'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedTab(String text, bool isSelected) {
    return HoverScale(
      child: Container(
        padding: const EdgeInsets.only(bottom: 2),
        decoration: isSelected
            ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE03A3E), width: 2)),
              )
            : null,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? const Color(0xFFE03A3E) : Colors.grey,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterItem(String text, bool isSelected) {
    return HoverScale(
      scale: 1.1,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: isSelected
              ? const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE03A3E), width: 2)),
                )
              : null,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: isSelected ? const Color(0xFFE03A3E) : Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String text, {bool italic = false}) {
    return HoverScale(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.5),
          color: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            fontStyle: italic ? FontStyle.italic : FontStyle.normal,
            decoration: italic ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarMenu(String text) {
    return HoverScale(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required String tag,
    required Color tagColor,
    required int scutes,
    required String title,
    required String description,
    required String userInitial,
    required String timeAgo,
    bool isMobile = false,
  }) {
    return HoverCard(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: tagColor,
                  child: Text(
                    tag,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 10),
                  ),
                ),
                Text(
                  '$scutes SCUTES',
                  style: TextStyle(
                    color: const Color(0xFFE03A3E),
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    shadows: isMobile ? const [Shadow(color: Colors.black, offset: Offset(1, 1))] : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
            ),
            const SizedBox(height: 30),
            const Divider(color: Colors.black, thickness: 1),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text('BY: ', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 10, color: Colors.grey)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(userInitial, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(timeAgo, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)),
                const Spacer(),
                HoverScale(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 12),
                    color: Colors.black,
                    child: const Text(
                      'GIVE SHELLP',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHashtag(String tag, String subtitle) {
    return HoverScale(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w900,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFFFD200),
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        fontSize: 12,
      ),
    );
  }
}

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
        onTap: widget.onTap ?? () {},
        child: AnimatedScale(
          scale: _isHovered ? widget.scale : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          child: widget.child,
        ),
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
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..translate(_isHovered ? -4.0 : 0.0, _isHovered ? -4.0 : 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: _isHovered
              ? [const BoxShadow(color: Color(0xFFFFD200), offset: Offset(4, 4), blurRadius: 0)]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
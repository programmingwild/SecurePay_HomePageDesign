import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ScrollBehavior _appScrollBehavior = const MaterialScrollBehavior().copyWith(
  dragDevices: <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  },
);

void main() {
  runApp(const SecurePayApp());
}

class SecurePayApp extends StatefulWidget {
  const SecurePayApp({super.key});

  @override
  State<SecurePayApp> createState() => _SecurePayAppState();
}

class _SecurePayAppState extends State<SecurePayApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _showOnboarding = true;

  void _toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void _completeOnboarding() {
    setState(() {
      _showOnboarding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget root = _showOnboarding
        ? PremiumOnboardingFlow(
            isDarkMode: _themeMode == ThemeMode.dark,
            onToggleThemeMode: _toggleThemeMode,
            onComplete: _completeOnboarding,
          )
        : SecurePayHomeScreen(
            isDarkMode: _themeMode == ThemeMode.dark,
            onToggleThemeMode: _toggleThemeMode,
          );

    return MaterialApp(
      title: 'SecurePay',
      debugShowCheckedModeBanner: false,
      scrollBehavior: _appScrollBehavior,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFDBE8FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3A63F3),
          brightness: Brightness.light,
        ),
        fontFamily: 'GoogleSans',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090E23),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3A63F3),
          brightness: Brightness.dark,
        ),
        fontFamily: 'GoogleSans',
      ),
      home: kIsWeb ? _WebPhoneEmulatorShell(child: root) : root,
    );
  }
}

class _WebPhoneEmulatorShell extends StatelessWidget {
  const _WebPhoneEmulatorShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const Size target = Size(1080, 2400);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double widthScale = constraints.maxWidth / target.width;
        final double heightScale = constraints.maxHeight / target.height;
        final double scale = math.min(widthScale, heightScale).clamp(0.55, 1.0);
        final double shellWidth = target.width * scale;
        final double shellHeight = target.height * scale;

        return Container(
          color: const Color(0xFF0A1027),
          alignment: Alignment.center,
          child: Container(
            width: shellWidth,
            height: shellHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: const Color(0xFF25345B), width: 1.3),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x66000000),
                  blurRadius: 30,
                  spreadRadius: 4,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class PremiumOnboardingFlow extends StatefulWidget {
  const PremiumOnboardingFlow({
    super.key,
    required this.isDarkMode,
    required this.onToggleThemeMode,
    required this.onComplete,
  });

  final bool isDarkMode;
  final VoidCallback onToggleThemeMode;
  final VoidCallback onComplete;

  @override
  State<PremiumOnboardingFlow> createState() => _PremiumOnboardingFlowState();
}

class _PremiumOnboardingFlowState extends State<PremiumOnboardingFlow> {
  late final PageController _pageController;
  int _index = 0;

  final List<_OnboardingSlideData> _slides = const <_OnboardingSlideData>[
    _OnboardingSlideData(
      icon: Icons.layers_rounded,
      title: 'Designed For Confident Payments',
      subtitle:
          'A cinematic wallet experience with smart motion, adaptive themes, and elite-grade transaction clarity.',
      accentA: Color(0xFF5D7BFF),
      accentB: Color(0xFF45E2C6),
      tags: <String>['Glass UI', 'Fluid Motion', 'Adaptive Theme'],
    ),
    _OnboardingSlideData(
      icon: Icons.shield_moon_rounded,
      title: 'Protection That Feels Invisible',
      subtitle:
          'AI risk scoring, trust signals, and pre-debit checks run in the background so your flow stays effortless.',
      accentA: Color(0xFF8A63FF),
      accentB: Color(0xFF5DA3FF),
      tags: <String>['Risk Engine', 'Device Trust', '24x7 Monitoring'],
    ),
    _OnboardingSlideData(
      icon: Icons.celebration_rounded,
      title: 'Every Successful Payment Feels Premium',
      subtitle:
          'Confetti success bursts, kinetic feedback, and elegant transaction states make every action delightful.',
      accentA: Color(0xFFFF7B9C),
      accentB: Color(0xFFFFC05A),
      tags: <String>['Success FX', 'Micro-interactions', 'Real-time Delight'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_index >= _slides.length - 1) {
      widget.onComplete();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> bg = widget.isDarkMode
        ? const <Color>[Color(0xFF040819), Color(0xFF0A1231), Color(0xFF1A0F3A)]
        : const <Color>[Color(0xFFF6FAFF), Color(0xFFE6F0FF), Color(0xFFDCE9FF)];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: bg,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _OnboardingBackdrop(isDarkMode: widget.isDarkMode),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'SecurePay',
                          style: TextStyle(
                            color: widget.isDarkMode ? const Color(0xFFF0F5FF) : const Color(0xFF123665),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: widget.onToggleThemeMode,
                          style: IconButton.styleFrom(
                            backgroundColor: widget.isDarkMode
                                ? Colors.white.withValues(alpha: 0.12)
                                : Colors.white.withValues(alpha: 0.82),
                          ),
                          icon: Icon(
                            widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                            color: widget.isDarkMode ? const Color(0xFFE7EEFF) : const Color(0xFF1E4478),
                          ),
                        ),
                        const SizedBox(width: 6),
                        TextButton(
                          onPressed: widget.onComplete,
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: widget.isDarkMode ? const Color(0xFFD2DEFF) : const Color(0xFF2B548E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _slides.length,
                      onPageChanged: (int next) {
                        setState(() {
                          _index = next;
                        });
                      },
                      itemBuilder: (BuildContext context, int i) {
                        return AnimatedPadding(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          padding: EdgeInsets.fromLTRB(8, i == _index ? 4 : 12, 8, i == _index ? 6 : 16),
                          child: _GlassOnboardingCard(
                            data: _slides[i],
                            isDarkMode: widget.isDarkMode,
                            active: i == _index,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(_slides.length, (int i) {
                            final bool active = i == _index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 260),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: active ? 30 : 9,
                              height: 9,
                              decoration: BoxDecoration(
                                color: active
                                    ? (widget.isDarkMode ? const Color(0xFF8BC7FF) : const Color(0xFF2F63F4))
                                    : (widget.isDarkMode ? Colors.white30 : const Color(0x663E5E8B)),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: <Widget>[
                            if (_index > 0)
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: widget.isDarkMode ? const Color(0xFF8BA5D9) : const Color(0xFF9AB4E6),
                                    ),
                                    foregroundColor: widget.isDarkMode ? const Color(0xFFE6EEFF) : const Color(0xFF1D447A),
                                    minimumSize: const Size.fromHeight(52),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  onPressed: () {
                                    _pageController.previousPage(
                                      duration: const Duration(milliseconds: 320),
                                      curve: Curves.easeOutCubic,
                                    );
                                  },
                                  child: const Text('Back'),
                                ),
                              ),
                            if (_index > 0) const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: widget.isDarkMode ? const Color(0xFF88A5FF) : const Color(0xFF325FFE),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(52),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                onPressed: _goNext,
                                child: Text(_index == _slides.length - 1 ? 'Enter SecurePay' : 'Next'),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _OnboardingBackdrop extends StatelessWidget {
  const _OnboardingBackdrop({required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: -120,
          top: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[
                  (isDarkMode ? const Color(0xFF5A79FF) : const Color(0xFF9BC5FF)).withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -100,
          top: 130,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: <Color>[
                  (isDarkMode ? const Color(0xFF00D3C9) : const Color(0xFFA2ECE0)).withValues(alpha: 0.44),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlassOnboardingCard extends StatelessWidget {
  const _GlassOnboardingCard({
    required this.data,
    required this.isDarkMode,
    required this.active,
  });

  final _OnboardingSlideData data;
  final bool isDarkMode;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      scale: active ? 1 : 0.96,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  (isDarkMode ? Colors.white : const Color(0xFFFDFEFF)).withValues(alpha: isDarkMode ? 0.12 : 0.82),
                  data.accentA.withValues(alpha: isDarkMode ? 0.18 : 0.24),
                  data.accentB.withValues(alpha: isDarkMode ? 0.18 : 0.22),
                ],
              ),
              border: Border.all(
                color: (isDarkMode ? Colors.white : const Color(0xFFB8CAEE)).withValues(alpha: isDarkMode ? 0.2 : 0.9),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: data.accentA.withValues(alpha: isDarkMode ? 0.2 : 0.18),
                  blurRadius: 34,
                  offset: const Offset(0, 16),
                ),
                BoxShadow(
                  color: data.accentB.withValues(alpha: isDarkMode ? 0.12 : 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: <Color>[data.accentA, data.accentB]),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: Icon(data.icon, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 18),
                Text(
                  data.title,
                  style: TextStyle(
                    color: isDarkMode ? const Color(0xFFF4F7FF) : const Color(0xFF102E59),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: isDarkMode ? const Color(0xFFD6DFF9) : const Color(0xFF335A8F),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: data.tags
                      .map(
                        (String label) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: (isDarkMode ? Colors.white : Colors.white).withValues(alpha: isDarkMode ? 0.12 : 0.86),
                            border: Border.all(
                              color: (isDarkMode ? Colors.white : const Color(0xFFB9CBEE))
                                  .withValues(alpha: isDarkMode ? 0.18 : 0.9),
                            ),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isDarkMode ? const Color(0xFFE4ECFF) : const Color(0xFF234A82),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecurePayHomeScreen extends StatefulWidget {
  const SecurePayHomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleThemeMode,
  });

  final bool isDarkMode;
  final VoidCallback onToggleThemeMode;

  @override
  State<SecurePayHomeScreen> createState() => _SecurePayHomeScreenState();
}

class _SecurePayHomeScreenState extends State<SecurePayHomeScreen> with SingleTickerProviderStateMixin {
  int _bottomIndex = 0;
  String _query = '';
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0);
  late final AnimationController _successController;
  Offset _successOrigin = const Offset(0.5, 0.78);
  bool _showSuccessFx = false;
  int _successBurstSeed = 0;

  Color get _textPrimary => widget.isDarkMode ? Colors.white : const Color(0xFF0F2450);
  Color get _textSecondary => widget.isDarkMode ? const Color(0xFFD0DAF7) : const Color(0xFF355389);
  Color get _textMuted => widget.isDarkMode ? const Color(0xFFBFCBE8) : const Color(0xFF58709D);
  Color get _surface =>
    widget.isDarkMode ? Colors.white.withValues(alpha: 0.08) : const Color(0xFFF4F8FF).withValues(alpha: 0.82);
  Color get _surfaceBorder =>
    widget.isDarkMode ? Colors.white.withValues(alpha: 0.18) : const Color(0xFFB6CBFA).withValues(alpha: 0.95);
  Color get _tileSurface =>
    widget.isDarkMode ? Colors.white.withValues(alpha: 0.10) : Colors.white.withValues(alpha: 0.80);
  Color get _tileBorder =>
    widget.isDarkMode ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFBFD2FB).withValues(alpha: 0.95);
  Color get _buttonBg => widget.isDarkMode ? Colors.white.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.76);
  Color get _buttonFg => widget.isDarkMode ? Colors.white : const Color(0xFF1C3B73);
  Color get _inputFill => widget.isDarkMode ? Colors.white.withValues(alpha: 0.09) : Colors.white.withValues(alpha: 0.86);
  Color get _inputBorder => widget.isDarkMode ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFABC3F6);
  Color get _heroTextPrimary => widget.isDarkMode ? Colors.white : const Color(0xFF163A6F);
  Color get _heroTextSecondary => widget.isDarkMode ? const Color(0xFFE5EDFF) : const Color(0xFF33598F);
  Color get _heroPillBg => widget.isDarkMode ? Colors.white.withValues(alpha: 0.14) : Colors.white.withValues(alpha: 0.82);
  Color get _heroPillText => widget.isDarkMode ? const Color(0xFFECF2FF) : const Color(0xFF1C416F);
  Color get _balancePrimary => widget.isDarkMode ? Colors.white : const Color(0xFF133461);
  Color get _balanceSecondary => widget.isDarkMode ? const Color(0xFFD6DEFF) : const Color(0xFF315688);

  final List<_ShortcutItem> _shortcuts = const <_ShortcutItem>[
    _ShortcutItem('Scan & Pay', Icons.qr_code_scanner_rounded, Color(0xFF4B7CFF)),
    _ShortcutItem('Send Money', Icons.phone_android_rounded, Color(0xFF00A884)),
    _ShortcutItem('Bank Transfer', Icons.account_balance_rounded, Color(0xFF8A5BFF)),
    _ShortcutItem('Wallet Top-Up', Icons.swap_horiz_rounded, Color(0xFFFF8A3D)),
    _ShortcutItem('Bill Pay', Icons.receipt_long_rounded, Color(0xFF2CB3B0)),
    _ShortcutItem('Recharge', Icons.flash_on_rounded, Color(0xFFEF5350)),
    _ShortcutItem('Cashback', Icons.call_received_rounded, Color(0xFF6D7C93)),
    _ShortcutItem('Rewards', Icons.history_rounded, Color(0xFF3A63F3)),
  ];

  final List<_Contact> _contacts = const <_Contact>[
    _Contact('Aarav', 'a@upi', Color(0xFF4B7CFF)),
    _Contact('Neha', 'n@upi', Color(0xFF00A884)),
    _Contact('Rahul', 'r@upi', Color(0xFF8A5BFF)),
    _Contact('Priya', 'p@upi', Color(0xFFFF8A3D)),
    _Contact('Kiran', 'k@upi', Color(0xFF2CB3B0)),
    _Contact('Meera', 'm@upi', Color(0xFFEF5350)),
  ];

  final List<_Transaction> _transactions = const <_Transaction>[
    _Transaction('Paid to Zomato', '-₹420', 'Today, 8:20 PM', true),
    _Transaction('Received from Aarav', '+₹1,200', 'Today, 2:11 PM', true),
    _Transaction('Electricity Bill', '-₹1,850', 'Yesterday, 10:05 AM', true),
    _Transaction('Refund - Flipkart', '+₹799', 'Mar 25, 4:40 PM', true),
    _Transaction('Paid to Cab Service', '-₹232', 'Mar 24, 9:11 AM', false),
  ];

  List<_Contact> get _filteredContacts {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) {
      return _contacts;
    }
    return _contacts
        .where((c) => c.name.toLowerCase().contains(q) || c.upiId.contains(q))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1050),
    )
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed && mounted) {
          setState(() {
            _showSuccessFx = false;
          });
        }
      });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollOffset.dispose();
    _successController.dispose();
    super.dispose();
  }

  Offset _normalizedFromGlobal(Offset globalPosition) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      return const Offset(0.5, 0.78);
    }
    final Offset local = box.globalToLocal(globalPosition);
    return Offset(
      (local.dx / box.size.width).clamp(0.12, 0.88),
      (local.dy / box.size.height).clamp(0.12, 0.92),
    );
  }

  void _triggerTransactionSuccess({
    String message = 'Payment successful',
    Offset? globalPosition,
  }) {
    final Offset nextOrigin = globalPosition == null
        ? const Offset(0.5, 0.78)
        : _normalizedFromGlobal(globalPosition);
    setState(() {
      _successOrigin = nextOrigin;
      _showSuccessFx = true;
      _successBurstSeed += 1;
    });
    HapticFeedback.mediumImpact();
    _successController.forward(from: 0);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
          backgroundColor: widget.isDarkMode ? const Color(0xFF1A2954) : const Color(0xFF204B8B),
        ),
      );
  }

  void _onScroll() {
    final double next = _scrollController.hasClients ? _scrollController.offset : 0;
    if ((next - _scrollOffset.value).abs() < 0.8) {
      return;
    }
    _scrollOffset.value = next;
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> pageGradient = widget.isDarkMode
        ? const <Color>[Color(0xFF060A1E), Color(0xFF0A1030), Color(0xFF1A0B35)]
        : const <Color>[Color(0xFFF8FBFF), Color(0xFFEAF2FF), Color(0xFFDBE8FF)];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: pageGradient,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ValueListenableBuilder<double>(
              valueListenable: _scrollOffset,
              builder: (BuildContext context, double offset, Widget? child) {
                return _ambientBackground(offset);
              },
            ),
            AnimatedBuilder(
              animation: _successController,
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final bool isDesktop = constraints.maxWidth >= 900;
                    final double maxWidth = constraints.maxWidth.clamp(320.0, 980.0).toDouble();

                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: maxWidth,
                        height: constraints.maxHeight,
                        child: CustomScrollView(
                          controller: _scrollController,
                          cacheExtent: 1200,
                          physics: kIsWeb
                              ? const ClampingScrollPhysics()
                              : const BouncingScrollPhysics(),
                          slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 0,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                              child: _header(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 60,
                              child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: _searchBar(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 110,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: _immersiveHeroPanel(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 160,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _balanceCard(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 220,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: _walletOfferRibbon(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 280,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _confidenceStrip(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 340,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _quickActions(isDesktop: isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 400,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _servicePills(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 460,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _trustProofSection(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 520,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _contactsSection(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 580,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              child: _billsAndOffers(isDesktop: isDesktop),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: _RevealIn(
                              delayMs: 640,
                              child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 14, 16, 104),
                              child: _transactionsSection(),
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                final double t = _successController.value;
                final double pulse = math.sin(math.pi * t.clamp(0, 0.4) / 0.4).clamp(0, 1) * 0.012;
                final double jitter = math.sin(t * math.pi * 18) * (1 - t) * 3.4;
                return Transform.translate(
                  offset: Offset(jitter, 0),
                  child: Transform.scale(
                    scale: 1 + pulse,
                    child: child,
                  ),
                );
              },
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _successController,
                  builder: (BuildContext context, Widget? child) {
                    if (!_showSuccessFx) {
                      return const SizedBox.shrink();
                    }
                    return _SuccessBurstOverlay(
                      progress: _successController.value,
                      seed: _successBurstSeed,
                      origin: _successOrigin,
                      isDarkMode: widget.isDarkMode,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomDock(),
    );
  }

  Widget _ambientBackground(double scrollOffset) {
    final double slowDrift = scrollOffset * 0.08;
    final double midDrift = scrollOffset * 0.12;
    final double beamDrift = scrollOffset * 0.16;

    final Color orbPrimary = widget.isDarkMode ? const Color(0xFF4B6BFF) : const Color(0xFF9FC3FF);
    final Color orbSecondary = widget.isDarkMode ? const Color(0xFF00D5C9) : const Color(0xFF8AE8D8);
    final Color beamPrimary = widget.isDarkMode ? const Color(0xFF6B87FF) : const Color(0xFFB8CCFF);
    final Color beamSecondary = widget.isDarkMode ? const Color(0xFF31D6B8) : const Color(0xFFA8ECD9);

    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -90,
            top: -80 - slowDrift,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    orbPrimary.withValues(alpha: widget.isDarkMode ? 0.45 : 0.36),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -120,
            top: 120 - midDrift,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    orbSecondary.withValues(alpha: widget.isDarkMode ? 0.22 : 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -80,
            top: -40 - beamDrift,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 240,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: <Color>[
                      beamPrimary.withValues(alpha: widget.isDarkMode ? 0.24 : 0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -70,
            bottom: 120 + beamDrift,
            child: Transform.rotate(
              angle: -0.55,
              child: Container(
                width: 210,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    colors: <Color>[
                      beamSecondary.withValues(alpha: widget.isDarkMode ? 0.18 : 0.14),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF1ED6FF), Color(0xFF5A72FF)],
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x6611C5FF), blurRadius: 18, offset: Offset(0, 8)),
            ],
          ),
          child: _ThreeDIconObject(
            icon: Icons.account_balance_wallet_rounded,
            baseColor: Color(0xFF57A6FF),
            size: 30,
            animate: true,
            spinDurationMs: 5600,
            isDarkMode: widget.isDarkMode,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello, User',
                style: TextStyle(
                  color: _textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Secure UPI, Wallet & Recharges',
                style: TextStyle(color: _textSecondary, fontSize: 13),
              ),
            ],
          ),
        ),
        FilledButton.tonalIcon(
          style: FilledButton.styleFrom(
            backgroundColor: _buttonBg,
            foregroundColor: _buttonFg,
            side: BorderSide(color: _tileBorder),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {},
          icon: const Icon(Icons.qr_code_2_rounded),
          label: const Text('Scan'),
        ),
        const SizedBox(width: 8),
        FilledButton.tonalIcon(
          style: FilledButton.styleFrom(
            backgroundColor: _buttonBg,
            foregroundColor: _buttonFg,
            side: BorderSide(color: _tileBorder),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: widget.onToggleThemeMode,
          icon: Icon(widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          label: Text(widget.isDarkMode ? 'Light' : 'Dark'),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: TextField(
          onChanged: (String value) {
            setState(() {
              _query = value;
            });
          },
          style: TextStyle(color: _textPrimary),
          decoration: InputDecoration(
            hintText: 'Search name, mobile, or UPI ID',
            hintStyle: TextStyle(color: _textSecondary),
            prefixIcon: Icon(Icons.search_rounded, color: _textSecondary),
            filled: true,
            fillColor: _inputFill,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: _inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF6FD6FF), width: 1.2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _immersiveHeroPanel() {
    return _HoverTilt(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0x663C56FF), Color(0x5534A0FF), Color(0x6630DFC8)],
                  ),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFF3E58FF).withValues(alpha: 0.20),
                      blurRadius: 26,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: const Color(0xFF5E92FF).withValues(alpha: 0.10),
                      blurRadius: 9,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _ThreeDIconObject(
                          icon: Icons.workspace_premium_rounded,
                          baseColor: Color(0xFF7E9DFF),
                          size: 30,
                          animate: true,
                          spinDurationMs: 5000,
                          isDarkMode: widget.isDarkMode,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Premium Security Layer Active',
                            style: TextStyle(color: _heroTextPrimary, fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: _heroPillBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'Live',
                            style: TextStyle(color: _heroPillText, fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'AI risk signals, device trust, and velocity checks are running before every debit.',
                      style: TextStyle(color: _heroTextSecondary, height: 1.35, fontSize: 12.5),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _TrustBadge(label: 'Latency 82ms', isDarkMode: widget.isDarkMode),
                        _TrustBadge(label: 'NPCI Rail Healthy', isDarkMode: widget.isDarkMode),
                        _TrustBadge(label: 'Auto Recovery On', isDarkMode: widget.isDarkMode),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: _AnimatedGradientSweep(isDarkMode: widget.isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _balanceCard() {
    return _HoverTilt(
      maxTiltRadians: 0.06,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0x803A57FF), Color(0x8049C6FF), Color(0x8044E8C2)],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFF3E58FF).withValues(alpha: 0.24),
              blurRadius: 28,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: const Color(0xFF5E92FF).withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SecurePay Wallet Balance',
              style: TextStyle(color: _balanceSecondary, fontSize: 13),
            ),
            SizedBox(height: 6),
            Text(
              '₹28,540.73',
              style: TextStyle(color: _balancePrimary, fontSize: 32, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Icon(
                  Icons.account_balance_rounded,
                  color: widget.isDarkMode ? Colors.white70 : const Color(0xFF4D6694),
                  size: 16,
                ),
                SizedBox(width: 6),
                Text('Linked Bank •••• 2184', style: TextStyle(color: _balancePrimary, fontSize: 13)),
                SizedBox(width: 14),
                Icon(
                  Icons.verified_rounded,
                  color: widget.isDarkMode ? Colors.white70 : const Color(0xFF4D6694),
                  size: 16,
                ),
                SizedBox(width: 6),
                Text('user@securepay', style: TextStyle(color: _balancePrimary, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _walletOfferRibbon() {
    return _HoverTilt(
      maxTiltRadians: 0.05,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Color(0x6662A0FF), Color(0x664EE6CC)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFF3E58FF).withValues(alpha: 0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: const Color(0xFF5E92FF).withValues(alpha: 0.08),
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    _ThreeDIconObject(
                      icon: Icons.local_offer_rounded,
                      baseColor: Color(0xFF57B4FF),
                      size: 28,
                      animate: true,
                      spinDurationMs: 4600,
                      isDarkMode: widget.isDarkMode,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Cashback up to 20% on first recharge and UPI transfer.',
                        style: TextStyle(
                          color: widget.isDarkMode ? const Color(0xFFF0F5FF) : const Color(0xFF1A4273),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: widget.isDarkMode ? Colors.white : const Color(0xFF1A4273),
                        backgroundColor: widget.isDarkMode
                            ? Colors.white.withValues(alpha: 0.14)
                            : Colors.white.withValues(alpha: 0.82),
                      ),
                      onPressed: () {},
                      child: const Text('View'),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: _AnimatedGradientSweep(durationMs: 2600, isDarkMode: widget.isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActions({required bool isDesktop}) {
    final int crossAxisCount = isDesktop ? 4 : 4;

    return _sectionCard(
      title: 'Quick Actions',
      child: GridView.builder(
        itemCount: _shortcuts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (BuildContext context, int index) {
          final _ShortcutItem item = _shortcuts[index];
          return _InteractiveTile(
            isDarkMode: widget.isDarkMode,
            onTapDown: (TapDownDetails details) {
              _triggerTransactionSuccess(
                message: '${item.label} completed',
                globalPosition: details.globalPosition,
              );
            },
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _ThreeDIconObject(
                  icon: item.icon,
                  baseColor: item.color,
                  isDarkMode: widget.isDarkMode,
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _confidenceStrip() {
    return Row(
      children: <Widget>[
        Expanded(
          child: _TrustStatTile(
            title: 'Trust Score',
            value: '98/100',
            icon: Icons.verified_user_rounded,
            color: Color(0xFF4AE2C2),
            isDarkMode: widget.isDarkMode,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TrustStatTile(
            title: 'Uptime',
            value: '99.99%',
            icon: Icons.bolt_rounded,
            color: Color(0xFF66B7FF),
            isDarkMode: widget.isDarkMode,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TrustStatTile(
            title: 'Fraud Block',
            value: '24x7',
            icon: Icons.shield_rounded,
            color: Color(0xFFC08BFF),
            isDarkMode: widget.isDarkMode,
          ),
        ),
      ],
    );
  }

  Widget _servicePills() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        _InfoPill(Icons.local_offer_rounded, 'Offers Zone', isDarkMode: widget.isDarkMode),
        _InfoPill(Icons.bolt_rounded, 'UPI Lite Active', isDarkMode: widget.isDarkMode),
        _InfoPill(Icons.autorenew_rounded, '2 AutoPay Mandates', isDarkMode: widget.isDarkMode),
        _InfoPill(Icons.security_rounded, 'Fraud Protection On', isDarkMode: widget.isDarkMode),
      ],
    );
  }

  Widget _trustProofSection() {
    return _sectionCard(
      title: 'Security & Trust Center',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _ThreeDIconObject(
                icon: Icons.lock_rounded,
                baseColor: Color(0xFF00A884),
                size: 30,
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'End-to-end encrypted UPI with real-time risk checks on every transaction.',
                  style: TextStyle(color: _textSecondary, height: 1.35, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _TrustBadge(label: 'RBI Aligned', isDarkMode: widget.isDarkMode),
              _TrustBadge(label: 'Device Binding', isDarkMode: widget.isDarkMode),
              _TrustBadge(label: 'Biometric Ready', isDarkMode: widget.isDarkMode),
              _TrustBadge(label: 'UPI Collect Guard', isDarkMode: widget.isDarkMode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactsSection() {
    final List<_Contact> current = _filteredContacts;

    return _sectionCard(
      title: 'Pay Contacts',
      trailing: TextButton(
        style: TextButton.styleFrom(foregroundColor: _textSecondary),
        onPressed: () {},
        child: const Text('See all'),
      ),
      child: current.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('No contacts found', style: TextStyle(color: _textMuted)),
            )
          : SizedBox(
              height: 86,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: current.length,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  final _Contact c = current[index];
                  return InkWell(
                    onTapDown: (TapDownDetails details) {
                      _triggerTransactionSuccess(
                        message: 'Paid ${c.name} successfully',
                        globalPosition: details.globalPosition,
                      );
                    },
                    onTap: () {},
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      width: 72,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: c.color.withValues(alpha: 0.18),
                            child: Text(
                              c.name.substring(0, 1),
                              style: TextStyle(color: c.color, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            c.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: _textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget _billsAndOffers({required bool isDesktop}) {
    final Widget bills = _sectionCard(
      title: 'Bills & Recharges',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _ServiceChip('Electricity', Icons.electric_bolt_rounded, isDarkMode: widget.isDarkMode),
          _ServiceChip('Mobile', Icons.phone_iphone_rounded, isDarkMode: widget.isDarkMode),
          _ServiceChip('DTH', Icons.live_tv_rounded, isDarkMode: widget.isDarkMode),
          _ServiceChip('Water', Icons.water_drop_rounded, isDarkMode: widget.isDarkMode),
          _ServiceChip('Gas', Icons.local_fire_department_rounded, isDarkMode: widget.isDarkMode),
          _ServiceChip('FASTag', Icons.directions_car_rounded, isDarkMode: widget.isDarkMode),
        ],
      ),
    );

    final Widget offers = _sectionCard(
      title: 'Rewards',
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: <Color>[Color(0x44FFE6AA), Color(0x33FFBE74)],
          ),
          border: Border.all(color: const Color(0x66FFECC2)),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.card_giftcard_rounded, color: Color(0xFFA05A00), size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Scratch cards waiting',
                    style: TextStyle(color: widget.isDarkMode ? Colors.white : const Color(0xFF15315F), fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Complete 1 more UPI payment to unlock rewards',
                    style: TextStyle(color: widget.isDarkMode ? const Color(0xFFE9EEFF) : const Color(0xFF304F83), fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (!isDesktop) {
      return Column(
        children: <Widget>[
          bills,
          const SizedBox(height: 12),
          offers,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: bills),
        const SizedBox(width: 12),
        Expanded(child: offers),
      ],
    );
  }

  Widget _transactionsSection() {
    return _sectionCard(
      title: 'Recent Transactions',
      trailing: TextButton(
        style: TextButton.styleFrom(foregroundColor: _textSecondary),
        onPressed: () {
          _triggerTransactionSuccess(message: 'Passbook synced');
        },
        child: const Text('Passbook'),
      ),
      child: Column(
        children: _transactions
            .map(
              (_Transaction t) => InkWell(
                borderRadius: BorderRadius.circular(12),
                onTapDown: (TapDownDetails details) {
                  _triggerTransactionSuccess(
                    message: '${t.title} confirmed',
                    globalPosition: details.globalPosition,
                  );
                },
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _tileSurface,
                    border: Border.all(color: _tileBorder),
                  ),
                  child: Row(
                    children: <Widget>[
                      _ThreeDIconObject(
                        icon: t.amount.startsWith('+')
                            ? Icons.call_received_rounded
                            : Icons.call_made_rounded,
                        baseColor:
                            t.amount.startsWith('+') ? const Color(0xFF00A884) : const Color(0xFF3A63F3),
                        size: 34,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              t.title,
                              style: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              t.time,
                              style: TextStyle(fontSize: 12, color: _textMuted),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            t.amount,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: t.amount.startsWith('+')
                                  ? const Color(0xFF00A884)
                                  : (widget.isDarkMode ? const Color(0xFFF3F7FF) : const Color(0xFF173A6F)),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: <Widget>[
                              Icon(
                                t.success ? Icons.check_circle_rounded : Icons.info_rounded,
                                size: 12,
                                color: t.success ? const Color(0xFF00A884) : const Color(0xFFEF5350),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                t.success ? 'Success' : 'Pending',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: t.success ? const Color(0xFF00A884) : const Color(0xFFEF5350),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required Widget child,
    Widget? trailing,
  }) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _surfaceBorder),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Color(0x33060B2D), blurRadius: 24, offset: Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (trailing case final Widget action) action,
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _bottomDock() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: _surface,
                indicatorColor: widget.isDarkMode ? const Color(0x6632CBFF) : const Color(0x99497EFF),
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return TextStyle(color: _textPrimary, fontWeight: FontWeight.w700);
                  }
                  return TextStyle(color: _textMuted);
                }),
                iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return IconThemeData(color: _textPrimary);
                  }
                  return IconThemeData(color: _textMuted);
                }),
              ),
              child: NavigationBar(
                selectedIndex: _bottomIndex,
                onDestinationSelected: (int value) {
                  setState(() {
                    _bottomIndex = value;
                  });
                },
                destinations: const <NavigationDestination>[
                  NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.account_balance_wallet_rounded), label: 'Balance'),
                  NavigationDestination(icon: Icon(Icons.qr_code_scanner_rounded), label: 'Scan'),
                  NavigationDestination(icon: Icon(Icons.help_outline_rounded), label: 'Help'),
                  NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill(this.icon, this.label, {required this.isDarkMode});

  final IconData icon;
  final String label;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isDarkMode ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFBFD2FB),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _ThreeDIconObject(icon: icon, baseColor: const Color(0xFF40D2FF), size: 24),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isDarkMode ? Colors.white : const Color(0xFF173A6F),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  const _ServiceChip(this.label, this.icon, {required this.isDarkMode});

  final String label;
  final IconData icon;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: _ThreeDIconObject(icon: icon, baseColor: const Color(0xFF5FC8FF), size: 24),
      label: Text(label),
      backgroundColor: isDarkMode ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.8),
      side: BorderSide.none,
      labelStyle: TextStyle(
        color: isDarkMode ? Colors.white : const Color(0xFF173A6F),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
  }
}

class _TrustStatTile extends StatelessWidget {
  const _TrustStatTile({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.isDarkMode,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return _HoverTilt(
      maxTiltRadians: 0.06,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.82),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDarkMode ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFBFD2FB),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _ThreeDIconObject(icon: icon, baseColor: color, size: 26),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF102348),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    color: isDarkMode ? const Color(0xFFBECCEE) : const Color(0xFF4A6594),
                    fontSize: 11,
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

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({required this.label, required this.isDarkMode});

  final String label;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: isDarkMode ? Colors.white.withValues(alpha: 0.16) : const Color(0xFFBFD2FB),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isDarkMode ? const Color(0xFFECF2FF) : const Color(0xFF1F3F73),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InteractiveTile extends StatefulWidget {
  const _InteractiveTile({
    required this.child,
    required this.isDarkMode,
    required this.onTap,
    this.onTapDown,
  });

  final Widget child;
  final bool isDarkMode;
  final VoidCallback onTap;
  final ValueChanged<TapDownDetails>? onTapDown;

  @override
  State<_InteractiveTile> createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<_InteractiveTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOutQuad),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HoverTilt(
      maxTiltRadians: 0.08,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          _pressController.forward();
          widget.onTapDown?.call(details);
        },
        onTapUp: (_) => _pressController.reverse(),
        onTapCancel: () => _pressController.reverse(),
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.white.withValues(alpha: 0.76),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: widget.isDarkMode
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFFB8D0FF),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF3E58FF).withValues(alpha: 0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: const Color(0xFF5E92FF).withValues(alpha: 0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _SuccessBurstOverlay extends StatelessWidget {
  const _SuccessBurstOverlay({
    required this.progress,
    required this.seed,
    required this.origin,
    required this.isDarkMode,
  });

  final double progress;
  final int seed;
  final Offset origin;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final double spark = (1 - progress).clamp(0, 1);
    return CustomPaint(
      painter: _ConfettiBurstPainter(
        progress: progress,
        seed: seed,
        origin: origin,
        isDarkMode: isDarkMode,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(
              (origin.dx * 2) - 1,
              (origin.dy * 2) - 1,
            ),
            child: Transform.scale(
              scale: 0.85 + (spark * 0.45),
              child: Opacity(
                opacity: spark * 0.7,
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 44,
                  color: isDarkMode ? const Color(0xFF9CF8E8) : const Color(0xFF1FAF8A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfettiBurstPainter extends CustomPainter {
  const _ConfettiBurstPainter({
    required this.progress,
    required this.seed,
    required this.origin,
    required this.isDarkMode,
  });

  final double progress;
  final int seed;
  final Offset origin;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    final double p = Curves.easeOutCubic.transform(progress.clamp(0, 1));
    final Offset center = Offset(origin.dx * size.width, origin.dy * size.height);
    final double fade = (1 - progress).clamp(0, 1);

    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = (isDarkMode ? const Color(0xFF8CE8FF) : const Color(0xFF2C74FF)).withValues(alpha: fade * 0.7);
    canvas.drawCircle(center, 18 + (p * 74), ring);

    final List<Color> palette = <Color>[
      const Color(0xFF4B7CFF),
      const Color(0xFF00D5C9),
      const Color(0xFFFFCA52),
      const Color(0xFFFF6C8A),
      const Color(0xFF7C5CFF),
      const Color(0xFF49E28A),
    ];

    for (int i = 0; i < 84; i++) {
      final double unit = (i + 1 + (seed * 13)).toDouble();
      final double angle = ((unit * 137.5) % 360) * math.pi / 180;
      final double speed = 38 + ((unit * 17.0) % 66);
      final double spread = speed * p;
      final double gravity = 160 * progress * progress;
      final double swirl = math.sin((progress * math.pi * 2.5) + unit) * 8;

      final double x = center.dx + (math.cos(angle) * spread) + swirl;
      final double y = center.dy - (math.sin(angle) * spread) + gravity;

      final double w = 3.5 + ((unit * 9.0) % 5.5);
      final double h = 2.2 + ((unit * 11.0) % 4.2);
      final double rot = angle + (progress * 6.4);
      final Color c = palette[i % palette.length].withValues(alpha: 0.22 + (fade * 0.78));

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(rot);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: w, height: h),
          const Radius.circular(1.2),
        ),
        Paint()..color = c,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiBurstPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.seed != seed ||
        oldDelegate.origin != origin ||
        oldDelegate.isDarkMode != isDarkMode;
  }
}

class _AnimatedGradientSweep extends StatefulWidget {
  const _AnimatedGradientSweep({this.durationMs = 3200, required this.isDarkMode});

  final int durationMs;
  final bool isDarkMode;

  @override
  State<_AnimatedGradientSweep> createState() => _AnimatedGradientSweepState();
}

class _AnimatedGradientSweepState extends State<_AnimatedGradientSweep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: widget.durationMs),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
          translation: Offset((_controller.value * 2.2) - 1.1, 0),
          child: Transform.rotate(
            angle: -0.28,
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.transparent,
                    Colors.white.withValues(alpha: widget.isDarkMode ? 0.2 : 0.12),
                    Colors.white.withValues(alpha: widget.isDarkMode ? 0.04 : 0.02),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HoverTilt extends StatefulWidget {
  const _HoverTilt({required this.child, this.maxTiltRadians = 0.07});

  final Widget child;
  final double maxTiltRadians;

  @override
  State<_HoverTilt> createState() => _HoverTiltState();
}

class _HoverTiltState extends State<_HoverTilt> {
  bool _hovering = false;
  double _dx = 0;
  double _dy = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() {
        _hovering = false;
        _dx = 0;
        _dy = 0;
      }),
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box == null || !box.hasSize) {
          return;
        }
        final Offset local = box.globalToLocal(event.position);
        final double nx = ((local.dx / box.size.width) - 0.5).clamp(-0.5, 0.5);
        final double ny = ((local.dy / box.size.height) - 0.5).clamp(-0.5, 0.5);
        setState(() {
          _dx = nx;
          _dy = ny;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateX(_hovering ? -_dy * widget.maxTiltRadians * 2 : 0)
          ..rotateY(_hovering ? _dx * widget.maxTiltRadians * 2 : 0),
        decoration: BoxDecoration(
          boxShadow: _hovering
              ? <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF3E58FF).withValues(alpha: 0.22),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                  ),
                  BoxShadow(
                    color: const Color(0xFF5E92FF).withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF3E58FF).withValues(alpha: 0.14),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: const Color(0xFF5E92FF).withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Transform.scale(
          scale: _hovering ? 1.02 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}

class _RevealIn extends StatelessWidget {
  const _RevealIn({
    required this.child,
    required this.delayMs,
  });

  final Widget child;
  final int delayMs;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 520 + delayMs),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double value, Widget? child) {
        final double eased = ((value * 1.08) - 0.08).clamp(0, 1);
        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(0, (1 - eased) * 14),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _ShortcutItem {
  const _ShortcutItem(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

class _OnboardingSlideData {
  const _OnboardingSlideData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentA,
    required this.accentB,
    required this.tags,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentA;
  final Color accentB;
  final List<String> tags;
}

class _ThreeDIconObject extends StatefulWidget {
  const _ThreeDIconObject({
    required this.icon,
    required this.baseColor,
    this.size = 36,
    this.animate = false,
    this.spinDurationMs = 5200,
    this.isDarkMode,
  });

  final IconData icon;
  final Color baseColor;
  final double size;
  final bool animate;
  final int spinDurationMs;
  final bool? isDarkMode;

  @override
  State<_ThreeDIconObject> createState() => _ThreeDIconObjectState();
}

class _ThreeDIconObjectState extends State<_ThreeDIconObject> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.spinDurationMs),
      )..repeat();
    }
  }

  @override
  void didUpdateWidget(covariant _ThreeDIconObject oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.animate && widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.spinDurationMs),
      )..repeat();
      return;
    }
    if (oldWidget.animate && !widget.animate) {
      _controller?.dispose();
      _controller = null;
      return;
    }
    if (widget.animate && oldWidget.spinDurationMs != widget.spinDurationMs) {
      _controller?.dispose();
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.spinDurationMs),
      )..repeat();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode = widget.isDarkMode ?? Theme.of(context).brightness == Brightness.dark;
    final double iconSize = widget.size * 0.48;

    Widget content(double phase) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _ProceduralMeshPainter(
                baseColor: widget.baseColor,
                phase: phase,
                isDarkMode: darkMode,
              ),
            ),
            Icon(
              widget.icon,
              size: iconSize,
              color: darkMode ? Colors.white : const Color(0xFF14305F),
            ),
          ],
        ),
      );
    }

    if (_controller == null) {
      return content(0.14);
    }

    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, Widget? child) {
        return content(_controller!.value);
      },
    );
  }
}

class _Vec3 {
  const _Vec3(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  _Vec3 operator +(_Vec3 other) => _Vec3(x + other.x, y + other.y, z + other.z);
  _Vec3 operator -(_Vec3 other) => _Vec3(x - other.x, y - other.y, z - other.z);
  _Vec3 operator *(double f) => _Vec3(x * f, y * f, z * f);

  double dot(_Vec3 other) => (x * other.x) + (y * other.y) + (z * other.z);

  _Vec3 cross(_Vec3 other) {
    return _Vec3(
      (y * other.z) - (z * other.y),
      (z * other.x) - (x * other.z),
      (x * other.y) - (y * other.x),
    );
  }

  double get length => math.sqrt((x * x) + (y * y) + (z * z));

  _Vec3 normalized() {
    final double l = length;
    if (l == 0) {
      return this;
    }
    return _Vec3(x / l, y / l, z / l);
  }
}

class _ProceduralMeshPainter extends CustomPainter {
  const _ProceduralMeshPainter({required this.baseColor, required this.phase, required this.isDarkMode});

  final Color baseColor;
  final double phase;
  final bool isDarkMode;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double w = size.width;

    // Primary glow layer
    final Paint glow = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          baseColor.withValues(alpha: isDarkMode ? 0.32 : 0.22),
          baseColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: w * 0.58));
    canvas.drawCircle(center.translate(0, w * 0.08), w * 0.58, glow);

    // Secondary glow layer for depth
    final Paint secondaryGlow = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          baseColor.withValues(alpha: isDarkMode ? 0.12 : 0.08),
          baseColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: w * 0.75));
    canvas.drawCircle(center.translate(0, w * 0.12), w * 0.75, secondaryGlow);

    final List<_Vec3> vertices = <_Vec3>[
      const _Vec3(-1, -1, -1),
      const _Vec3(1, -1, -1),
      const _Vec3(1, 1, -1),
      const _Vec3(-1, 1, -1),
      const _Vec3(-1, -1, 1),
      const _Vec3(1, -1, 1),
      const _Vec3(1, 1, 1),
      const _Vec3(-1, 1, 1),
    ];

    final double rx = 0.18 + (math.sin(phase * math.pi * 2) * 0.08);
    final double ry = 0.32 + (math.cos(phase * math.pi * 2) * 0.18);
    final double rz = -0.08 + (math.sin((phase * math.pi * 2) + 0.9) * 0.08);

    _Vec3 rotate(_Vec3 v) {
      final double cx = math.cos(rx);
      final double sx = math.sin(rx);
      final double cy = math.cos(ry);
      final double sy = math.sin(ry);
      final double cz = math.cos(rz);
      final double sz = math.sin(rz);

      final _Vec3 xRot = _Vec3(v.x, (v.y * cx) - (v.z * sx), (v.y * sx) + (v.z * cx));
      final _Vec3 yRot = _Vec3((xRot.x * cy) + (xRot.z * sy), xRot.y, (-xRot.x * sy) + (xRot.z * cy));
      return _Vec3((yRot.x * cz) - (yRot.y * sz), (yRot.x * sz) + (yRot.y * cz), yRot.z);
    }

    final List<_Vec3> r = vertices.map(rotate).toList();

    Offset project(_Vec3 v) {
      const double distance = 4.4;
      final double scale = (w * 0.29) / (distance - v.z);
      return Offset(center.dx + (v.x * scale), center.dy + (v.y * scale));
    }

    final List<Offset> p = r.map(project).toList();

    final List<List<int>> faces = <List<int>>[
      <int>[0, 1, 2, 3],
      <int>[4, 5, 6, 7],
      <int>[0, 3, 7, 4],
      <int>[1, 2, 6, 5],
      <int>[0, 1, 5, 4],
      <int>[3, 2, 6, 7],
    ];

    final List<Map<String, dynamic>> order = faces
        .map((List<int> f) => <String, dynamic>{
              'face': f,
              'z': (r[f[0]].z + r[f[1]].z + r[f[2]].z + r[f[3]].z) / 4,
            })
        .toList()
      ..sort((Map<String, dynamic> a, Map<String, dynamic> b) =>
          (a['z'] as double).compareTo(b['z'] as double));

    final _Vec3 lightDir = const _Vec3(0.45, -0.7, 1.0).normalized();

    for (final Map<String, dynamic> item in order) {
      final List<int> f = item['face'] as List<int>;

      final _Vec3 n = (r[f[1]] - r[f[0]]).cross(r[f[2]] - r[f[0]]).normalized();
      final double lum = ((n.dot(lightDir) + 1) / 2).clamp(0.1, 1.0);

      final Color faceColor = Color.lerp(
        Color.lerp(baseColor, Colors.black, isDarkMode ? 0.38 : 0.28),
        Color.lerp(baseColor, Colors.white, isDarkMode ? 0.22 : 0.12),
        lum,
      )!.withValues(alpha: 0.96);

      final Path path = Path()
        ..moveTo(p[f[0]].dx, p[f[0]].dy)
        ..lineTo(p[f[1]].dx, p[f[1]].dy)
        ..lineTo(p[f[2]].dx, p[f[2]].dy)
        ..lineTo(p[f[3]].dx, p[f[3]].dy)
        ..close();

      canvas.drawPath(path, Paint()..color = faceColor);
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = (isDarkMode ? Colors.white : const Color(0xFF4E6694)).withValues(alpha: 0.22),
      );
    }

    final Paint gloss = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white.withValues(alpha: isDarkMode ? 0.34 : 0.22),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(center.dx - (w * 0.26), center.dy - (w * 0.26), w * 0.42, w * 0.32));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - (w * 0.28), center.dy - (w * 0.28), w * 0.48, w * 0.32),
        Radius.circular(w * 0.14),
      ),
      gloss,
    );
  }

  @override
  bool shouldRepaint(covariant _ProceduralMeshPainter oldDelegate) {
    return oldDelegate.phase != phase ||
        oldDelegate.baseColor != baseColor ||
        oldDelegate.isDarkMode != isDarkMode;
  }
}

class _Contact {
  const _Contact(this.name, this.upiId, this.color);

  final String name;
  final String upiId;
  final Color color;
}

class _Transaction {
  const _Transaction(this.title, this.amount, this.time, this.success);

  final String title;
  final String amount;
  final String time;
  final bool success;
}

import 'dart:ui';
import 'package:flutter/material.dart';

class AuthBackgroundLayout extends StatelessWidget {
  final Widget child;
  final bool showBackButton;

  const AuthBackgroundLayout({
    super.key, 
    required this.child,
    this.showBackButton = false,
  });

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: showBackButton 
        ? AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF1B5E20)),
          )
        : null,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE8F5E9),
                    Color(0xFFA5D6A7),
                    Color(0xFF388E3C),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: -80,
            child: _buildBlurCircle(300, Colors.white.withValues(alpha: 0.3)),
          ),
          Positioned(
            bottom: -50,
            left: -100,
            child: _buildBlurCircle(400, const Color(0xFF1B5E20).withValues(alpha: 0.3)),
          ),
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}

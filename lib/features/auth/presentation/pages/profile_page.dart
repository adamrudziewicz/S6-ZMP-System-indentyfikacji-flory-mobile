import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../main.dart';
import '../../../../core/biometry/biometry_service.dart';
import '../../../../core/security/security_service.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isBiometryEnabled = false;
  bool _isSecureScreenEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final biometryService = context.read<BiometryService>();
    final securityService = context.read<SecurityService>();
    
    final biometryEnabled = await biometryService.isBiometryEnabled();
    final secureScreenEnabled = await securityService.isSecureScreenEnabled();
    
    setState(() {
      _isBiometryEnabled = biometryEnabled;
      _isSecureScreenEnabled = secureScreenEnabled;
    });
  }

  Future<void> _toggleSecureScreen() async {
    final service = context.read<SecurityService>();
    final newValue = !_isSecureScreenEnabled;
    await service.setSecureScreenEnabled(newValue);
    setState(() {
      _isSecureScreenEnabled = newValue;
    });
  }

  Future<void> _toggleBiometry() async {
    final service = context.read<BiometryService>();
    final canCheck = await service.canCheckBiometrics();
    
    if (!canCheck) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n?.biometryNotSupported ?? 'Twoje urządzenie nie obsługuje biometrii.')),
      );
      return;
    }

    final newValue = !_isBiometryEnabled;
    await service.setBiometryEnabled(newValue);
    setState(() {
      _isBiometryEnabled = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          String username = 'Użytkownik';
          String email = '';

          if (state is AuthAuthenticated && state.user != null) {
            username = state.user!.username;
            email = state.user!.email;
          }

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              _buildSliverAppBar(l10n),
              SliverPadding(
                padding: const EdgeInsets.all(24.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildProfileHeader(username, email),
                    const SizedBox(height: 40),
                    _buildSettingsSection(context, l10n),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(AppLocalizations l10n) {
    return SliverAppBar(
      expandedHeight: 140.0,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1B5E20),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
        title: Text(
          l10n.profileTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(String username, String email) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.shade100,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Text(
              username.isNotEmpty ? username[0].toUpperCase() : 'U',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.green.shade800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          username,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.settingsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingsCard(
          icon: Icons.language_rounded,
          title: l10n.appLanguage,
          subtitle: l10n.currentLanguage,
          onTap: () {
            _showLanguageDialog(context, l10n);
          },
        ),
        const SizedBox(height: 12),
        _buildSettingsCard(
          icon: Icons.screenshot_monitor_rounded,
          title: l10n.secureScreenTitle,
          subtitle: l10n.secureScreenSubtitle,
          trailing: Switch(
            value: _isSecureScreenEnabled,
            onChanged: (_) => _toggleSecureScreen(),
            activeColor: const Color(0xFF2E7D32),
          ),
          onTap: _toggleSecureScreen,
        ),
        const SizedBox(height: 12),
        _buildSettingsCard(
          icon: Icons.fingerprint_rounded,
          title: l10n.biometryTitle,
          subtitle: _isBiometryEnabled ? l10n.biometryEnabled : l10n.biometryDisabled,
          trailing: Switch(
            value: _isBiometryEnabled,
            onChanged: (_) => _toggleBiometry(),
            activeColor: const Color(0xFF2E7D32),
          ),
          onTap: _toggleBiometry,
        ),
        const SizedBox(height: 32),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            icon: const Icon(Icons.logout_rounded),
            label: Text(l10n.logout, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            onPressed: () {
              _showLogoutDialog(context, l10n);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard({required IconData icon, required String title, required String subtitle, required VoidCallback onTap, Widget? trailing}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF2E7D32), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
            trailing ?? Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.logoutConfirmationTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(l10n.logoutConfirmationContent),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              child: Text(l10n.logout),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.chooseLanguageTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text('🇵🇱', style: TextStyle(fontSize: 24)),
                title: Text(l10n.polish),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  MyApp.setLocale(context, const Locale('pl'));
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: Text(l10n.english),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onTap: () {
                  MyApp.setLocale(context, const Locale('en'));
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/presentation/app_colors.dart';
import '../../../../core/presentation/widgets/language_selector.dart';
import '../widgets/auth_layout.dart';
import '../widgets/login_form.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isBiometryAvailable = false;
  
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _animController.forward();
    context.read<AuthBloc>().add(AuthLoadCredentialsRequested());
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AuthBackgroundLayout(
      child: SizedBox.expand(
        child: Stack(
          children: [
          Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.white.withValues(alpha: 0.5), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(Icons.eco_rounded, size: 72, color: AppColors.primary),
                            const SizedBox(height: 16),
                            Text(
                              l10n.appTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryDark,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 40),
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthCredentialsLoaded) {
                                  setState(() {
                                    _loginController.text = state.login;
                                    _passwordController.text = state.password;
                                    _rememberMe = state.rememberMe;
                                    _isBiometryAvailable = state.isBiometryAvailable;
                                  });
                                }
                              },
                              child: LoginForm(
                                loginController: _loginController,
                                passwordController: _passwordController,
                                rememberMe: _rememberMe,
                                isBiometryAvailable: _isBiometryAvailable,
                                onRememberMeChanged: (val) {
                                  setState(() {
                                    _rememberMe = val;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(l10n.noAccountText, style: TextStyle(color: Colors.grey.shade700)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                                    );
                                  },
                                  child: Text(
                                    l10n.registerButton,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LanguageSelector(),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

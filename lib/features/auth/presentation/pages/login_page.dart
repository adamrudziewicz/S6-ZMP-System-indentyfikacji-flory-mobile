import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/biometry/biometry_service.dart';
import '../../../../core/storage/storage_service.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'register_page.dart';
import '../../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isPasswordObscure = true;
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
    _checkBiometryAndLoadCredentials();
  }

  Future<void> _checkBiometryAndLoadCredentials() async {
    final biometryService = context.read<BiometryService>();
    final storageService = context.read<StorageService>();

    final canCheck = await biometryService.canCheckBiometrics();
    final isEnabled = await biometryService.isBiometryEnabled();
    final savedUser = await storageService.getSavedUsername();
    final savedPass = await storageService.getSavedPassword();
    
    final storedRememberMe = await storageService.getRememberMe();
    
    if (savedUser != null) {
      setState(() {
        _loginController.text = savedUser;
        if (savedPass != null && storedRememberMe) {
          _passwordController.text = savedPass;
        }
        _rememberMe = storedRememberMe;
      });
    }

    setState(() {
      _isBiometryAvailable = canCheck && isEnabled && savedUser != null && savedPass != null;
    });
  }

  Future<void> _performBiometricLogin() async {
    final biometryService = context.read<BiometryService>();
    final storageService = context.read<StorageService>();

    final authenticated = await biometryService.authenticate();
    if (authenticated) {
      final username = await storageService.getSavedUsername();
      final password = await storageService.getSavedPassword();
      if (username != null && password != null) {
        if (!mounted) return;
        context.read<AuthBloc>().add(
          AuthLoginRequested(username, password, rememberMe: _rememberMe),
        );
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Weryfikacja biometryczna nie powiodła się.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: -50,
            child: _buildBlurCircle(300, Colors.white.withOpacity(0.3)),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: _buildBlurCircle(400, const Color(0xFF1B5E20).withOpacity(0.4)),
          ),

          SafeArea(
            child: Center(
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
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Icon(Icons.eco_rounded, size: 72, color: Color(0xFF2E7D32)),
                            const SizedBox(height: 16),
                            Text(
                              l10n.appTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1B5E20),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 40),
                            _buildTextField(
                              controller: _loginController,
                              label: l10n.usernameLabel,
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: _passwordController,
                              label: l10n.passwordLabel,
                              icon: Icons.lock_outline_rounded,
                              isObscure: _isPasswordObscure,
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordObscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF2E7D32)),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordObscure = !_isPasswordObscure;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: _rememberMe,
                                        activeColor: const Color(0xFF2E7D32),
                                        onChanged: (val) {
                                          setState(() {
                                            _rememberMe = val ?? false;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.rememberMe,
                                      style: TextStyle(
                                        color: Colors.green.shade800,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    _showForgotPasswordDialog(context, l10n);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(0xFF2E7D32),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Text(l10n.forgotPasswordButton, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                final l10n = AppLocalizations.of(context)!;
                                if (state is AuthError) {
                                  String msg;
                                  SnackBarAction? action;
                                  switch (state.message) {
                                    case 'forgot_password_error':
                                      msg = l10n.forgotPasswordErrorMessage;
                                      break;
                                    case 'login_invalid_credentials':
                                      msg = l10n.loginInvalidCredentialsError;
                                      break;
                                    case 'login_invalid_request':
                                      msg = l10n.loginInvalidRequestError;
                                      break;
                                    case 'email_not_verified':
                                      msg = l10n.emailNotVerifiedError;
                                      action = SnackBarAction(
                                        label: l10n.resendVerificationButton,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          final login = _loginController.text.trim();
                                          if (login.isNotEmpty) {
                                            context.read<AuthBloc>().add(AuthResendVerificationEmailRequested(login));
                                          }
                                        },
                                      );
                                      break;
                                    case 'resend_verification_error':
                                      msg = l10n.resendVerificationErrorMessage;
                                      break;
                                    default:
                                      msg = l10n.loginErrorMessage;
                                  }
                                  setState(() {
                                    _errorMessage = msg;
                                  });

                                  _passwordController.selection = TextSelection.collapsed(
                                    offset: _passwordController.text.length,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(msg),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      action: action,
                                    ),
                                  );
                                } else if (state is AuthActionSuccess) {
                                  String successMsg = '';
                                  if (state.message == 'forgot_password_success') {
                                    successMsg = l10n.forgotPasswordSuccessMessage;
                                  } else if (state.message == 'resend_verification_success') {
                                    successMsg = l10n.resendVerificationSuccessMessage;
                                  } else if (state.message == 'register_success') {
                                    successMsg = l10n.registerSuccessMessage;
                                  }
                                  if (successMsg.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(successMsg),
                                        backgroundColor: Colors.green.shade700,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      ),
                                    );
                                  }
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    if (state is AuthLoading)
                                      const Center(child: CircularProgressIndicator(color: Color(0xFF2E7D32)))
                                    else
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF2E7D32),
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(vertical: 18),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              ),
                                              onPressed: () {
                                                context.read<AuthBloc>().add(
                                                  AuthLoginRequested(_loginController.text, _passwordController.text, rememberMe: _rememberMe),
                                                );
                                              },
                                              child: Text(l10n.loginButton, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                            ),
                                          ),
                                          if (_isBiometryAvailable) ...[
                                            const SizedBox(width: 12),
                                            IconButton.filledTonal(
                                              icon: const Icon(Icons.fingerprint_rounded, size: 36),
                                              onPressed: _performBiometricLogin,
                                              style: IconButton.styleFrom(
                                                backgroundColor: Colors.green.shade50,
                                                foregroundColor: const Color(0xFF2E7D32),
                                                padding: const EdgeInsets.all(12),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                  ],
                                );
                              },
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
                                      color: Color(0xFF2E7D32),
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
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PopupMenuButton<String>(
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      Localizations.localeOf(context).languageCode.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  onSelected: (String langCode) {
                    MyApp.setLocale(context, Locale(langCode));
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'pl',
                      child: Text('PL', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const PopupMenuItem<String>(
                      value: 'en',
                      child: Text('EN', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50), child: Container(color: Colors.transparent)),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, bool isObscure = false, Widget? suffixIcon}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context, AppLocalizations l10n) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(l10n.resetPasswordTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.resetPasswordMessage),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.emailLabel,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  this.context.read<AuthBloc>().add(AuthForgotPasswordRequested(email));
                  Navigator.pop(ctx);
                }
              },
              child: Text(l10n.sendLinkButton),
            ),
          ],
        );
      },
    );
  }
}

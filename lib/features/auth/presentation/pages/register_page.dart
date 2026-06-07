import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/utils/password_validator.dart';
import '../widgets/auth_layout.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isPasswordObscure = true;

  PasswordStrength _passwordStrength = const PasswordStrength(
    hasMinLength: false,
    hasUppercase: false,
    hasLowercase: false,
    hasNumber: false,
    hasSpecialChar: false,
  );

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    _animController.forward();
  }

  void _validatePassword() {
    setState(() {
      _passwordStrength = PasswordValidator.validate(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePassword);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AuthBackgroundLayout(
      showBackButton: true,
      child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.5),
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
                            Text(
                              l10n.registerTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1B5E20),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.registerSubtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 40),
                            CustomTextField(
                              controller: _usernameController,
                              label: l10n.usernameLabel,
                              icon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _emailController,
                              label: l10n.emailLabel,
                              icon: Icons.alternate_email_rounded,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
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
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildRequirementChip(l10n.pwdMinLength, _passwordStrength.hasMinLength),
                                _buildRequirementChip(l10n.pwdUppercase, _passwordStrength.hasUppercase),
                                _buildRequirementChip(l10n.pwdLowercase, _passwordStrength.hasLowercase),
                                _buildRequirementChip(l10n.pwdNumber, _passwordStrength.hasNumber),
                                _buildRequirementChip(l10n.pwdSpecial, _passwordStrength.hasSpecialChar),
                              ],
                            ),
                            const SizedBox(height: 24),
                            BlocConsumer<AuthBloc, AuthState>(
                              listener: (context, state) {
                                final l10n = AppLocalizations.of(context)!;
                                if (state is AuthError) {
                                  final msg = state.getLocalizedMessage(l10n);
                                  
                                  setState(() {
                                    _errorMessage = msg;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(msg),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                } else if (state is AuthRegisterSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.registerSuccessMessage),
                                      backgroundColor: Colors.green.shade700,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    if (_errorMessage != null) ...[
                                      Text(
                                        _errorMessage!,
                                        style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                    if (state is AuthLoading)
                                      const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: CircularProgressIndicator(color: Color(0xFF2E7D32)),
                                        ),
                                      )
                                    else
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
                                              blurRadius: 15,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF2E7D32),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 18),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                            elevation: 0,
                                          ),
                                          onPressed: _passwordStrength.isValid
                                              ? () {
                                                  FocusScope.of(context).unfocus();
                                                  setState(() => _errorMessage = null);
                                                  context.read<AuthBloc>().add(
                                                    AuthRegisterRequested(
                                                      _usernameController.text,
                                                      _emailController.text,
                                                      _passwordController.text,
                                                    ),
                                                  );
                                                }
                                              : null,
                                          child: Text(l10n.createAccountButton, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildRequirementChip(String label, bool isValid) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isValid ? Colors.green.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isValid ? Colors.green.shade400 : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isValid ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 16,
            color: isValid ? Colors.green.shade600 : Colors.grey.shade500,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isValid ? FontWeight.w600 : FontWeight.w500,
              color: isValid ? Colors.green.shade700 : Colors.grey.shade600,
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
}

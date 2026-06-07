import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/presentation/app_colors.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'forgot_password_dialog.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool isBiometryAvailable;
  final ValueChanged<bool> onRememberMeChanged;

  const LoginForm({
    super.key,
    required this.loginController,
    required this.passwordController,
    required this.rememberMe,
    required this.isBiometryAvailable,
    required this.onRememberMeChanged,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isPasswordObscure = true;
  String? _errorMessage;

  void _performBiometricLogin() {
    context.read<AuthBloc>().add(AuthBiometricLoginRequested());
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const ForgotPasswordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: widget.loginController,
          label: l10n.usernameLabel,
          icon: Icons.person_outline_rounded,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: widget.passwordController,
          label: l10n.passwordLabel,
          icon: Icons.lock_outline_rounded,
          isObscure: _isPasswordObscure,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordObscure ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primary,
            ),
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
                    value: widget.rememberMe,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      widget.onRememberMeChanged(val ?? false);
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
              onPressed: () => _showForgotPasswordDialog(context),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                l10n.forgotPasswordButton,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              final msg = state.getLocalizedMessage(l10n);
              SnackBarAction? action;
              
              if (state is AuthErrorEmailNotVerified) {
                action = SnackBarAction(
                  label: l10n.resendVerificationButton,
                  textColor: AppColors.white,
                  onPressed: () {
                    final login = widget.loginController.text.trim();
                    if (login.isNotEmpty) {
                      context.read<AuthBloc>().add(AuthResendVerificationEmailRequested(login));
                    }
                  },
                );
              }
              
              setState(() {
                _errorMessage = msg;
              });

              widget.passwordController.selection = TextSelection.collapsed(
                offset: widget.passwordController.text.length,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  action: action,
                ),
              );
            } else if (state is AuthActionSuccess) {
              final successMsg = state.getLocalizedMessage(l10n);
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
                  const Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                widget.loginController.text,
                                widget.passwordController.text,
                                rememberMe: widget.rememberMe,
                              ),
                            );
                          },
                          child: Text(
                            l10n.loginButton,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      if (widget.isBiometryAvailable) ...[
                        const SizedBox(width: 12),
                        IconButton.filledTonal(
                          icon: const Icon(Icons.fingerprint_rounded, size: 36),
                          onPressed: _performBiometricLogin,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.green.shade50,
                            foregroundColor: AppColors.primary,
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
      ],
    );
  }
}

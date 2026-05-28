import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'l10n/app_localizations.dart';
import 'dependency_provider.dart';
import 'core/security/security_service.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'core/presentation/pages/main_navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase init failed (ensure google-services.json is present): $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    context.findAncestorStateOfType<_MyAppState>()?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return DependencyProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? 'System Identyfikacji Flory',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pl'),
          Locale('en'),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    context.read<SecurityService>().init();
    context.read<AuthBloc>().add(AuthStarted());
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => previous is AuthAuthenticated && current is AuthUnauthenticated,
      listener: (context, state) {
        ScaffoldMessenger.of(context).clearSnackBars();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthAuthenticated,
        listener: (context, state) {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
          if (state is AuthInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthAuthenticated) {
            return const MainNavigationPage();
          } else {
            return const LoginPage();
          }
        },
      ),
      ),
    );
  }
}

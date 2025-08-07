import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moti_app/features/home/presentation/pages/home_page.dart';
import 'package:moti_app/features/quotes/presentation/pages/quotes_page.dart';
import 'package:moti_app/features/favorites/presentation/pages/favorites_page.dart';
import 'package:moti_app/features/profile/presentation/pages/profile_page.dart';
import 'package:moti_app/features/admin/presentation/pages/admin_page.dart';
import 'package:moti_app/features/auth/presentation/pages/login_page.dart';
import 'package:moti_app/features/auth/presentation/pages/splash_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Login
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      
      // Main App Shell
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          
          // Quotes
          GoRoute(
            path: '/quotes',
            builder: (context, state) => const QuotesPage(),
          ),
          
          // Favorites
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesPage(),
          ),
          
          // Profile
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
          
          // Admin (ruta protegida)
          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminPage(),
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final Widget child;
  
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Frases',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/home':
        return 0;
      case '/quotes':
        return 1;
      case '/favorites':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/quotes');
        break;
      case 2:
        context.go('/favorites');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
} 
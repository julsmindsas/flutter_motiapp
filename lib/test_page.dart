import 'package:flutter/material.dart';
import 'package:moti_app/core/theme/app_theme.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      appBar: AppBar(
        title: const Text('MotiApp - TEST'),
        backgroundColor: AppTheme.primaryBlack,
        foregroundColor: AppTheme.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.cardGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.cardShadow,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.format_quote,
                    color: AppTheme.gold,
                    size: 60,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'MotiApp - Frases Motivadoras Premium',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '"El éxito no es final, el fracaso no es fatal: es el coraje para continuar lo que cuenta."',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.white,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '- Winston Churchill',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.gold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.gold,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      'PALETA LUXURY APLICADA ✓',
                      style: TextStyle(
                        color: AppTheme.primaryBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
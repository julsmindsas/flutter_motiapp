import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moti_app/core/providers/quotes_provider.dart';
import 'package:moti_app/core/theme/app_theme.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.luxuryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.gold,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.gold.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: AppTheme.primaryBlack,
                        size: 30,
                      ),
                    ),
                    
                    const SizedBox(width: 15),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mis Favoritos',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Frases que te han inspirado',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.silverGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Contenido
              Expanded(
                child: Consumer<QuotesProvider>(
                  builder: (context, quotesProvider, child) {
                    // Simular favoritos (en una implementación real vendría de SharedPreferences)
                    final favorites = quotesProvider.quotes.take(2).toList();
                    
                    if (favorites.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: AppTheme.mediumGray.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                size: 60,
                                color: AppTheme.silverGray.withOpacity(0.5),
                              ),
                            ),
                            
                            const SizedBox(height: 30),
                            
                            Text(
                              'No tienes favoritos aún',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            const SizedBox(height: 10),
                            
                            Text(
                              'Guarda las frases que más te inspiren\npara encontrarlas fácilmente',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.silverGray,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            const SizedBox(height: 30),
                            
                            ElevatedButton.icon(
                              onPressed: () {
                                // Navegar a frases
                              },
                              icon: const Icon(Icons.format_quote),
                              label: const Text('Explorar Frases'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.gold,
                                foregroundColor: AppTheme.primaryBlack,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final quote = favorites[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: _buildFavoriteCard(quote),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(Quote quote) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.secondaryBlack, AppTheme.darkGray],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con badge de favorito
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.gold,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: AppTheme.primaryBlack,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Favorito',
                        style: TextStyle(
                          color: AppTheme.primaryBlack,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                IconButton(
                  onPressed: () {
                    // Remover de favoritos
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: AppTheme.gold,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            
            // Texto de la frase
            Text(
              '"${quote.text}"',
              style: const TextStyle(
                color: AppTheme.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 15),
            
            // Autor y categoría
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '- ${quote.author}',
                    style: const TextStyle(
                      color: AppTheme.gold,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.mediumGray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    quote.category,
                    style: const TextStyle(
                      color: AppTheme.silverGray,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            
            // Acciones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Estadísticas
                Row(
                  children: [
                    _buildStatItem(
                      Icons.favorite_border,
                      '${quote.likes}',
                    ),
                    
                    const SizedBox(width: 15),
                    
                    _buildStatItem(
                      Icons.share,
                      '${quote.shares}',
                    ),
                  ],
                ),
                
                // Botones de acción
                Row(
                  children: [
                    _buildActionButton(
                      Icons.share,
                      () {},
                    ),
                    
                    const SizedBox(width: 10),
                    
                    _buildActionButton(
                      Icons.more_vert,
                      () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppTheme.silverGray,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: const TextStyle(
            color: AppTheme.silverGray,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppTheme.mediumGray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: AppTheme.silverGray,
          size: 16,
        ),
      ),
    );
  }
} 
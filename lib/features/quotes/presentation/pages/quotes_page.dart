import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moti_app/core/providers/quotes_provider.dart';
import 'package:moti_app/core/theme/app_theme.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  String _selectedCategory = 'Todas';
  final List<String> _categories = [
    'Todas',
    'Motivación',
    'Éxito',
    'Amor',
    'Vida',
  ];

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
                    IconButton(
                      onPressed: () {
                        // Buscar
                      },
                      icon: const Icon(
                        Icons.search,
                        color: AppTheme.white,
                        size: 28,
                      ),
                    ),
                    
                    const SizedBox(width: 15),
                    
                    Expanded(
                      child: Text(
                        'Frases Motivadoras',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    
                    IconButton(
                      onPressed: () {
                        // Filtros
                      },
                      icon: const Icon(
                        Icons.filter_list,
                        color: AppTheme.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Filtros de categorías
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = category == _selectedCategory;
                    
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.gold : AppTheme.mediumGray.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected ? AppTheme.gold : AppTheme.mediumGray,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? AppTheme.primaryBlack : AppTheme.white,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Lista de frases
              Expanded(
                child: Consumer<QuotesProvider>(
                  builder: (context, quotesProvider, child) {
                    if (quotesProvider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                        ),
                      );
                    }
                    
                    List<Quote> filteredQuotes = quotesProvider.quotes;
                    if (_selectedCategory != 'Todas') {
                      filteredQuotes = quotesProvider.quotes
                          .where((quote) => quote.category == _selectedCategory)
                          .toList();
                    }
                    
                    if (filteredQuotes.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.format_quote,
                              size: 80,
                              color: AppTheme.silverGray.withOpacity(0.5),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No hay frases en esta categoría',
                              style: TextStyle(
                                color: AppTheme.silverGray,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Prueba con otra categoría',
                              style: TextStyle(
                                color: AppTheme.silverGray.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    return RefreshIndicator(
                      onRefresh: () async {
                        // Recargar frases
                      },
                      color: AppTheme.gold,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredQuotes.length,
                        itemBuilder: (context, index) {
                          final quote = filteredQuotes[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: _buildQuoteCard(quote),
                          );
                        },
                      ),
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

  Widget _buildQuoteCard(Quote quote) {
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
            // Texto de la frase
            Text(
              '"${quote.text}"',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.white,
                fontWeight: FontWeight.w500,
                height: 1.3,
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.gold,
                      fontWeight: FontWeight.w600,
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
                    style: TextStyle(
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
                      Icons.favorite_border,
                      () {},
                    ),
                    
                    const SizedBox(width: 10),
                    
                    _buildActionButton(
                      Icons.share,
                      () {},
                    ),
                    
                    const SizedBox(width: 10),
                    
                    _buildActionButton(
                      Icons.bookmark_border,
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
          style: TextStyle(
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
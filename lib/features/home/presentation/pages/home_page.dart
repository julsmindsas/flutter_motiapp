import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moti_app/core/providers/quotes_provider.dart';
import 'package:moti_app/core/providers/ads_provider.dart';
import 'package:moti_app/core/theme/app_theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final quotesProvider = context.read<QuotesProvider>();
    final adsProvider = context.read<AdsProvider>();
    
    await quotesProvider.loadDailyQuote();
    adsProvider.initializeAds();
  }

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
                        Icons.format_quote,
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
                            'Bienvenido',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Tu inspiración diaria',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.silverGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    IconButton(
                      onPressed: () {
                        // Notificaciones
                      },
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Contenido principal
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
                    
                    return RefreshIndicator(
                      onRefresh: () async {
                        await quotesProvider.loadDailyQuote();
                      },
                      color: AppTheme.gold,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Frase del día
                            if (quotesProvider.dailyQuote != null) ...[
                              _buildDailyQuoteCard(quotesProvider.dailyQuote!),
                              const SizedBox(height: 30),
                            ],
                            
                            // Sección de categorías
                            Text(
                              'Categorías',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            const SizedBox(height: 15),
                            
                            // Grid de categorías
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1.5,
                              children: [
                                _buildCategoryCard(
                                  'Motivación',
                                  Icons.trending_up,
                                  AppTheme.gold,
                                ),
                                _buildCategoryCard(
                                  'Éxito',
                                  Icons.star,
                                  AppTheme.premiumGold,
                                ),
                                _buildCategoryCard(
                                  'Amor',
                                  Icons.favorite,
                                  Colors.pink,
                                ),
                                _buildCategoryCard(
                                  'Vida',
                                  Icons.psychology,
                                  Colors.blue,
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 30),
                            
                            // Banner de publicidad
                            Consumer<AdsProvider>(
                              builder: (context, adsProvider, child) {
                                if (adsProvider.isBannerAdLoaded && adsProvider.bannerAd != null) {
                                  return Container(
                                    height: 60,
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    child: AdWidget(ad: adsProvider.bannerAd!),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Frases recientes
                            Text(
                              'Frases recientes',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            const SizedBox(height: 15),
                            
                            // Lista de frases recientes
                            Consumer<QuotesProvider>(
                              builder: (context, quotesProvider, child) {
                                if (quotesProvider.quotes.isEmpty) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(40),
                                      child: Text(
                                        'No hay frases disponibles',
                                        style: TextStyle(color: AppTheme.silverGray),
                                      ),
                                    ),
                                  );
                                }
                                
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: quotesProvider.quotes.take(3).length,
                                  itemBuilder: (context, index) {
                                    final quote = quotesProvider.quotes[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 15),
                                      child: _buildQuoteCard(quote),
                                    );
                                  },
                                );
                              },
                            ),
                            
                            const SizedBox(height: 100), // Espacio para bottom navigation
                          ],
                        ),
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

  Widget _buildDailyQuoteCard(Quote quote) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.secondaryBlack, AppTheme.darkGray],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge "Frase del día"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.gold,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Frase del día',
                style: TextStyle(
                  color: AppTheme.primaryBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Texto de la frase
            Text(
              '"${quote.text}"',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.white,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Autor
            Row(
              children: [
                Container(
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppTheme.gold,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                const SizedBox(width: 10),
                
                Text(
                  '- ${quote.author}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.gold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            // Acciones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Categoría
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.mediumGray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    quote.category,
                    style: TextStyle(
                      color: AppTheme.silverGray,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                // Botones de acción
                Row(
                  children: [
                    _buildActionButton(
                      Icons.favorite_border,
                      '${quote.likes}',
                      () {},
                    ),
                    
                    const SizedBox(width: 15),
                    
                    _buildActionButton(
                      Icons.share,
                      '${quote.shares}',
                      () {},
                    ),
                    
                    const SizedBox(width: 15),
                    
                    _buildActionButton(
                      Icons.bookmark_border,
                      '',
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
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navegar a categoría específica
          },
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
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

  Widget _buildActionButton(IconData icon, String count, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.mediumGray.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppTheme.silverGray,
              size: 18,
            ),
            if (count.isNotEmpty) ...[
              const SizedBox(width: 5),
              Text(
                count,
                style: TextStyle(
                  color: AppTheme.silverGray,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 
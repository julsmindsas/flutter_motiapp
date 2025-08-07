import 'package:flutter/material.dart';
import 'package:moti_app/core/models/quote.dart';
import 'package:moti_app/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DailyQuoteWidget extends StatelessWidget {
  final Quote quote;
  final VoidCallback onQuoteViewed;

  const DailyQuoteWidget({
    super.key,
    required this.quote,
    required this.onQuoteViewed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onQuoteViewed,
      child: Container(
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
        child: Stack(
          children: [
            // Imagen de fondo (si existe)
            if (quote.imageUrl != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: quote.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.darkGray,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.darkGray,
                      child: const Icon(
                        Icons.image,
                        color: AppTheme.silverGray,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            
            // Overlay para mejorar legibilidad
            if (quote.imageUrl != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
            
            // Contenido de la frase
            Padding(
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
                            () {
                              // Acción de like
                            },
                          ),
                          
                          const SizedBox(width: 15),
                          
                          _buildActionButton(
                            Icons.share,
                            '${quote.shares}',
                            () {
                              // Acción de compartir
                            },
                          ),
                          
                          const SizedBox(width: 15),
                          
                          _buildActionButton(
                            Icons.bookmark_border,
                            '',
                            () {
                              // Acción de guardar
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
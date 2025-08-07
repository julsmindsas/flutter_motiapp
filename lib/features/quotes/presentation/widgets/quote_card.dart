import 'package:flutter/material.dart';
import 'package:moti_app/core/models/quote.dart';
import 'package:moti_app/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback onQuoteViewed;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.onQuoteViewed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onQuoteViewed,
      child: Container(
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
        child: Stack(
          children: [
            // Imagen de fondo (si existe)
            if (quote.imageUrl != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
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
                        size: 40,
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
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
            
            // Contenido de la frase
            Padding(
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
                            () {
                              // Acción de like
                            },
                          ),
                          
                          const SizedBox(width: 10),
                          
                          _buildActionButton(
                            Icons.share,
                            () {
                              // Acción de compartir
                            },
                          ),
                          
                          const SizedBox(width: 10),
                          
                          _buildActionButton(
                            Icons.bookmark_border,
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
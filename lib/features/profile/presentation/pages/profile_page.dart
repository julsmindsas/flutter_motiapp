import 'package:flutter/material.dart';
import 'package:moti_app/core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppTheme.gold, AppTheme.premiumGold],
                        ),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.gold.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppTheme.primaryBlack,
                        size: 40,
                      ),
                    ),
                    
                    const SizedBox(width: 20),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usuario Premium',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          const SizedBox(height: 5),
                          
                          Text(
                            'usuario@motiapp.com',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.silverGray,
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.gold,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Usuario Premium',
                              style: TextStyle(
                                color: AppTheme.primaryBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    IconButton(
                      onPressed: () {
                        // Configuración
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: AppTheme.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Estadísticas
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Frases vistas', '156', Icons.visibility),
                    _buildStatItem('Favoritos', '23', Icons.favorite),
                    _buildStatItem('Compartidas', '8', Icons.share),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Menú de opciones
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      _buildMenuItem(
                        icon: Icons.favorite,
                        title: 'Mis Favoritos',
                        subtitle: 'Frases guardadas',
                        onTap: () {},
                      ),
                      
                      _buildMenuItem(
                        icon: Icons.history,
                        title: 'Historial',
                        subtitle: 'Frases recientes',
                        onTap: () {},
                      ),
                      
                      _buildMenuItem(
                        icon: Icons.notifications,
                        title: 'Notificaciones',
                        subtitle: 'Configurar alertas',
                        onTap: () {},
                      ),
                      
                      _buildMenuItem(
                        icon: Icons.share,
                        title: 'Compartir App',
                        subtitle: 'Recomendar a amigos',
                        onTap: () {},
                      ),
                      
                      _buildMenuItem(
                        icon: Icons.star,
                        title: 'Calificar App',
                        subtitle: 'Tu opinión es importante',
                        onTap: () {},
                      ),
                      
                      _buildMenuItem(
                        icon: Icons.help,
                        title: 'Ayuda y Soporte',
                        subtitle: 'Preguntas frecuentes',
                        onTap: () {},
                      ),
                      
                      _buildMenuItem(
                        icon: Icons.privacy_tip,
                        title: 'Privacidad',
                        subtitle: 'Política de privacidad',
                        onTap: () {},
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Botón de cerrar sesión
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppTheme.secondaryBlack, AppTheme.darkGray],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Cerrar sesión
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red.withOpacity(0.8),
                                    size: 24,
                                  ),
                                  
                                  const SizedBox(width: 15),
                                  
                                  Text(
                                    'Cerrar Sesión',
                                    style: TextStyle(
                                      color: Colors.red.withOpacity(0.8),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 100), // Espacio para bottom navigation
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.mediumGray.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: AppTheme.gold,
            size: 24,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.silverGray,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.secondaryBlack, AppTheme.darkGray],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.mediumGray.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.gold,
                    size: 20,
                  ),
                ),
                
                const SizedBox(width: 15),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppTheme.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppTheme.silverGray,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppTheme.silverGray,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 
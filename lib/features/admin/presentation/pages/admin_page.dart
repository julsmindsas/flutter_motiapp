import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moti_app/core/providers/auth_provider.dart';
import 'package:moti_app/core/providers/quotes_provider.dart';
import 'package:moti_app/core/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _authorController = TextEditingController();
  final _categoryController = TextEditingController();
  
  String _selectedCategory = 'Motivación';
  File? _selectedImage;
  bool _isLoading = false;
  
  final List<String> _categories = [
    'Motivación',
    'Éxito',
    'Amor',
    'Vida',
    'General',
  ];

  @override
  void dispose() {
    _textController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _submitQuote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final quotesProvider = context.read<QuotesProvider>();
      
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await quotesProvider.uploadQuoteImage(_selectedImage!.path);
      }

      await quotesProvider.addQuote(
        text: _textController.text.trim(),
        author: _authorController.text.trim(),
        imageUrl: imageUrl,
        category: _selectedCategory,
      );

      // Limpiar formulario
      _textController.clear();
      _authorController.clear();
      setState(() {
        _selectedImage = null;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Frase agregada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.white,
                      ),
                    ),
                    
                    Expanded(
                      child: Text(
                        'Panel de Administrador',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.gold,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings,
                        color: AppTheme.primaryBlack,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Contenido
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de sección
                        Text(
                          'Agregar nueva frase',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Campo de texto de la frase
                        TextFormField(
                          controller: _textController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Frase motivadora',
                            hintText: 'Escribe aquí la frase...',
                            prefixIcon: Icon(Icons.format_quote),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa la frase';
                            }
                            if (value.length < 10) {
                              return 'La frase debe tener al menos 10 caracteres';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Campo de autor
                        TextFormField(
                          controller: _authorController,
                          decoration: const InputDecoration(
                            labelText: 'Autor',
                            hintText: 'Nombre del autor',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa el autor';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Selector de categoría
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Categoría',
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: _categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Selector de imagen
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryBlack,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.mediumGray,
                              width: 2,
                            ),
                          ),
                          child: _selectedImage != null
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _selectedImage!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedImage = null;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: AppTheme.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: _pickImage,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate,
                                        color: AppTheme.silverGray,
                                        size: 50,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Agregar imagen (opcional)',
                                        style: TextStyle(
                                          color: AppTheme.silverGray,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Toca para seleccionar',
                                        style: TextStyle(
                                          color: AppTheme.silverGray.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Botón de envío
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitQuote,
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppTheme.primaryBlack,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'Agregar frase',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Estadísticas
                        Container(
                          padding: const EdgeInsets.all(20),
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
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estadísticas',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              const SizedBox(height: 15),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStatCard(
                                      'Total frases',
                                      '0',
                                      Icons.format_quote,
                                    ),
                                  ),
                                  
                                  const SizedBox(width: 15),
                                  
                                  Expanded(
                                    child: _buildStatCard(
                                      'Frases del día',
                                      '0',
                                      Icons.today,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.mediumGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.mediumGray.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.gold,
            size: 24,
          ),
          
          const SizedBox(height: 8),
          
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 4),
          
          Text(
            title,
            style: TextStyle(
              color: AppTheme.silverGray,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 
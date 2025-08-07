import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quote {
  final String id;
  final String text;
  final String author;
  final String category;
  final DateTime createdAt;
  final int likes;
  final int shares;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    required this.createdAt,
    this.likes = 0,
    this.shares = 0,
  });

  Quote copyWith({
    String? id,
    String? text,
    String? author,
    String? category,
    DateTime? createdAt,
    int? likes,
    int? shares,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares,
    );
  }
}

class QuotesProvider extends ChangeNotifier {
  List<Quote> _quotes = [];
  Quote? _dailyQuote;
  List<Quote> _favorites = [];
  bool _isLoading = false;
  String? _error;
  int _quoteViewCount = 0;

  List<Quote> get quotes => _quotes;
  Quote? get dailyQuote => _dailyQuote;
  List<Quote> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  QuotesProvider() {
    _loadSampleQuotes();
    _loadFavorites();
    _loadQuoteViewCount();
  }

  void _loadSampleQuotes() {
    _quotes = [
      Quote(
        id: '1',
        text: 'El éxito no es final, el fracaso no es fatal: es el coraje para continuar lo que cuenta.',
        author: 'Winston Churchill',
        category: 'Motivación',
        createdAt: DateTime.now(),
        likes: 1250,
        shares: 340,
      ),
      Quote(
        id: '2',
        text: 'La vida es lo que pasa mientras estás ocupado haciendo otros planes.',
        author: 'John Lennon',
        category: 'Vida',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likes: 890,
        shares: 210,
      ),
      Quote(
        id: '3',
        text: 'El futuro pertenece a aquellos que creen en la belleza de sus sueños.',
        author: 'Eleanor Roosevelt',
        category: 'Éxito',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        likes: 1560,
        shares: 420,
      ),
      Quote(
        id: '4',
        text: 'La felicidad no es algo hecho. Viene de tus propias acciones.',
        author: 'Dalai Lama',
        category: 'Vida',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        likes: 980,
        shares: 280,
      ),
      Quote(
        id: '5',
        text: 'El amor es paciente, el amor es bondadoso. No tiene envidia, no se jacta, no es orgulloso.',
        author: 'San Pablo',
        category: 'Amor',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        likes: 1120,
        shares: 310,
      ),
    ];

    _dailyQuote = _quotes.first;
    notifyListeners();
  }

  Future<void> loadDailyQuote() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulación de carga de frase del día
      await Future.delayed(const Duration(milliseconds: 500));
      _dailyQuote = _quotes[DateTime.now().millisecond % _quotes.length];
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Error al cargar la frase del día';
      notifyListeners();
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favorites') ?? [];
      
      _favorites = _quotes.where((quote) => favoriteIds.contains(quote.id)).toList();
      notifyListeners();
    } catch (e) {
      _error = 'Error al cargar favoritos';
      notifyListeners();
    }
  }

  Future<void> _loadQuoteViewCount() async {
    final prefs = await SharedPreferences.getInstance();
    _quoteViewCount = prefs.getInt('quoteViewCount') ?? 0;
  }

  Future<void> _incrementQuoteViewCount() async {
    _quoteViewCount++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quoteViewCount', _quoteViewCount);
  }

  void onQuoteViewed() async {
    await _incrementQuoteViewCount();
    
    // Mostrar anuncio cada 3 frases vistas
    if (_quoteViewCount % 3 == 0) {
      // Esta lógica se implementará con AdsProvider
    }
  }

  Future<void> toggleFavorite(Quote quote) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorites') ?? [];
      
      if (favorites.contains(quote.id)) {
        favorites.remove(quote.id);
      } else {
        favorites.add(quote.id);
      }
      
      await prefs.setStringList('favorites', favorites);
      await _loadFavorites();
    } catch (e) {
      _error = 'Error al actualizar favoritos';
      notifyListeners();
    }
  }

  bool isFavorite(String quoteId) {
    return _favorites.any((quote) => quote.id == quoteId);
  }

  Future<void> likeQuote(Quote quote) async {
    try {
      // Simulación de like
      await Future.delayed(const Duration(milliseconds: 300));
      
      final index = _quotes.indexWhere((q) => q.id == quote.id);
      if (index != -1) {
        _quotes[index] = _quotes[index].copyWith(likes: _quotes[index].likes + 1);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error al dar like';
      notifyListeners();
    }
  }

  Future<void> shareQuote(Quote quote) async {
    try {
      // Simulación de compartir
      await Future.delayed(const Duration(milliseconds: 300));
      
      final index = _quotes.indexWhere((q) => q.id == quote.id);
      if (index != -1) {
        _quotes[index] = _quotes[index].copyWith(shares: _quotes[index].shares + 1);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error al compartir';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 
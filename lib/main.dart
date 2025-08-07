import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// ===== SERVICIO DE NOTIFICACIONES =====
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
    await _requestPermissions();
    await _scheduleDailyNotification();
  }

  static Future<void> _requestPermissions() async {
    await Permission.notification.request();
  }

  static Future<void> _scheduleDailyNotification() async {
    await _notifications.periodicallyShow(
      0,
      'Motivación Empresarial Diaria',
      'Tu frase motivacional te está esperando',
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_quotes',
          'Daily Entrepreneur Quotes',
          channelDescription: 'Motivational quotes for entrepreneurs',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await NotificationService.initialize();
  runApp(const EntrepreneurMotiApp());
}

class EntrepreneurMotiApp extends StatelessWidget {
  const EntrepreneurMotiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entrepreneur Mindset - Luxury Motivation',
      debugShowCheckedModeBanner: false,
      theme: LuxuryTheme.theme,
      home: const EntrepreneurHomePage(),
    );
  }
}

// ===== PALETA DE COLORES LUXURY ENTREPRENEUR =====
class LuxuryColors {
  static const Color deepBlack = Color(0xFF000000);
  static const Color richBlack = Color(0xFF0D0D0D);
  static const Color luxuryGray = Color(0xFF1A1A1A);
  static const Color charcoalGray = Color(0xFF2D2D2D);
  static const Color silverGray = Color(0xFF4A4A4A);
  static const Color lightGray = Color(0xFF6D6D6D);
  static const Color platinum = Color(0xFF9D9D9D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFF3D3D3D);
  static const Color success = Color(0xFF4CAF50);
}

// ===== TEMA LUXURY PARA EMPRENDEDORES =====
class LuxuryTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: LuxuryColors.deepBlack,
      colorScheme: const ColorScheme.dark(
        primary: LuxuryColors.platinum,
        secondary: LuxuryColors.silverGray,
        surface: LuxuryColors.luxuryGray,
        background: LuxuryColors.deepBlack,
        onPrimary: LuxuryColors.deepBlack,
        onSecondary: LuxuryColors.white,
        onSurface: LuxuryColors.white,
        onBackground: LuxuryColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: LuxuryColors.deepBlack,
        foregroundColor: LuxuryColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: LuxuryColors.white, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(color: LuxuryColors.white, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: LuxuryColors.white, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: LuxuryColors.platinum, fontWeight: FontWeight.w400),
      ),
    );
  }
}

// ===== BANNER DE PUBLICIDAD =====
class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null || !_isAdLoaded) {
      return Container(
        height: 60,
        color: LuxuryColors.charcoalGray,
        child: const Center(
          child: Text(
            'Cargando publicidad...',
            style: TextStyle(color: LuxuryColors.lightGray),
          ),
        ),
      );
    }

    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: LuxuryColors.luxuryGray,
        border: Border(
          top: BorderSide(color: LuxuryColors.charcoalGray, width: 1),
        ),
      ),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

// ===== PÁGINA PRINCIPAL =====
class EntrepreneurHomePage extends StatefulWidget {
  const EntrepreneurHomePage({super.key});

  @override
  State<EntrepreneurHomePage> createState() => _EntrepreneurHomePageState();
}

class _EntrepreneurHomePageState extends State<EntrepreneurHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const EntrepreneurMotivationPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _pages[_currentIndex]),
          const AdBanner(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: LuxuryColors.luxuryGray,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, -3),
            ),
          ],
          border: const Border(
            top: BorderSide(color: LuxuryColors.charcoalGray, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: LuxuryColors.platinum,
          unselectedItemColor: LuxuryColors.lightGray,
          elevation: 0,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_outlined),
              activeIcon: Icon(Icons.trending_up),
              label: 'Motivación',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              activeIcon: Icon(Icons.bookmark),
              label: 'Guardadas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

// ===== FRASES MOTIVADORAS PARA EMPRENDEDORES =====
class EntrepreneurQuotes {
  static final List<Map<String, String>> quotes = [
    {
      'quote': '"El éxito no se logra solo con cualidades especiales. Es sobre todo un trabajo de constancia, de método y de organización."',
      'author': 'J.P. Sergent'
    },
    {
      'quote': '"No tengas miedo de renunciar a lo bueno para perseguir lo grandioso."',
      'author': 'John D. Rockefeller'
    },
    {
      'quote': '"El fracaso es simplemente la oportunidad de comenzar de nuevo, esta vez de forma más inteligente."',
      'author': 'Henry Ford'
    },
    {
      'quote': '"Tu red de contactos es tu patrimonio neto."',
      'author': 'Porter Gale'
    },
    {
      'quote': '"La innovación distingue a los líderes de los seguidores."',
      'author': 'Steve Jobs'
    },
    {
      'quote': '"El emprendedor siempre busca el cambio, responde a él y lo explota como una oportunidad."',
      'author': 'Peter Drucker'
    },
    {
      'quote': '"Lo más difícil de crear una empresa no es tener una gran idea o recaudar dinero, es convertirte en líder."',
      'author': 'Ali Tamaseb'
    },
    {
      'quote': '"El éxito es caminar de fracaso en fracaso sin perder el entusiasmo."',
      'author': 'Winston Churchill'
    },
    {
      'quote': '"Tu trabajo va a llenar gran parte de tu vida, y la única manera de estar verdaderamente satisfecho es hacer lo que crees que es un gran trabajo."',
      'author': 'Steve Jobs'
    },
    {
      'quote': '"Las oportunidades no aparecen, las creas."',
      'author': 'Chris Grosser'
    },
    {
      'quote': '"El único lugar donde el éxito viene antes que el trabajo es en el diccionario."',
      'author': 'Vidal Sassoon'
    },
    {
      'quote': '"No construyas un negocio, construye un sueño."',
      'author': 'Jack Ma'
    },
    {
      'quote': '"El riesgo viene de no saber lo que estás haciendo."',
      'author': 'Warren Buffett'
    },
    {
      'quote': '"Los grandes líderes están dispuestos a sacrificar los números para salvar a las personas."',
      'author': 'Simon Sinek'
    },
    {
      'quote': '"El dinero no es el principal motivador de los emprendedores; es la libertad de crear."',
      'author': 'Richard Branson'
    },
    {
      'quote': '"En el mundo de los negocios, el espejo retrovisor siempre es más claro que el parabrisas."',
      'author': 'Warren Buffett'
    },
    {
      'quote': '"Una idea no vale nada a menos que puedas ejecutarla."',
      'author': 'David Karp'
    },
    {
      'quote': '"No esperes por la oportunidad perfecta. Tómala y hazla perfecta."',
      'author': 'Tory Burch'
    },
    {
      'quote': '"La única manera de hacer un gran trabajo es amar lo que haces."',
      'author': 'Steve Jobs'
    },
    {
      'quote': '"El cliente más insatisfecho es tu mejor fuente de aprendizaje."',
      'author': 'Bill Gates'
    },
    {
      'quote': '"Si no construyes tu sueño, alguien más te contratará para ayudar a construir el suyo."',
      'author': 'Dhirubhai Ambani'
    },
    {
      'quote': '"El precio del éxito es trabajo duro, dedicación y determinación."',
      'author': 'Vince Lombardi'
    },
    {
      'quote': '"No se trata de ideas. Se trata de hacer que las ideas sucedan."',
      'author': 'Scott Belsky'
    },
    {
      'quote': '"Prefiero ser un optimista y estar equivocado que ser un pesimista y tener razón."',
      'author': 'Elon Musk'
    },
    {
      'quote': '"El éxito no es definitivo, el fracaso no es fatal: es el coraje para continuar lo que cuenta."',
      'author': 'Winston Churchill'
    },
    {
      'quote': '"Si tu negocio no está en internet, tu negocio estará fuera del negocio."',
      'author': 'Bill Gates'
    },
    {
      'quote': '"La diferencia entre ganador y perdedor es que el ganador lo ha intentado dos veces más."',
      'author': 'Lisa Leslie'
    },
    {
      'quote': '"Un negocio tiene que ser involucrado, tiene que ser divertido, y tiene que ejercitar tu instinto creativo."',
      'author': 'Richard Branson'
    },
    {
      'quote': '"El momento perfecto no existe. Empieza desde donde estás, usa lo que tienes, haz lo que puedas."',
      'author': 'Arthur Ashe'
    },
    {
      'quote': '"La persistencia es el trabajo duro que haces después de estar cansado del trabajo duro que ya hiciste."',
      'author': 'Newt Gingrich'
    },
  ];

  static Map<String, String> getDailyQuote() {
    final today = DateTime.now();
    final index = today.day % quotes.length;
    return quotes[index];
  }
}

// ===== PÁGINA PRINCIPAL DE MOTIVACIÓN =====
class EntrepreneurMotivationPage extends StatefulWidget {
  const EntrepreneurMotivationPage({super.key});

  @override
  State<EntrepreneurMotivationPage> createState() => _EntrepreneurMotivationPageState();
}

class _EntrepreneurMotivationPageState extends State<EntrepreneurMotivationPage> {
  void _shareQuote(Map<String, String> quote) {
    final shareText = '${quote['quote']}\n\n— ${quote['author']}\n\n#EntrepreneurMindset';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final dailyQuote = EntrepreneurQuotes.getDailyQuote();
    
    return Scaffold(
      backgroundColor: LuxuryColors.deepBlack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: true,
            pinned: true,
            backgroundColor: LuxuryColors.deepBlack,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [LuxuryColors.platinum, LuxuryColors.silverGray],
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: LuxuryColors.platinum.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.trending_up,
                      color: LuxuryColors.deepBlack,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entrepreneur',
                          style: TextStyle(
                            color: LuxuryColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mindset Luxury',
                          style: TextStyle(
                            color: LuxuryColors.platinum,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [LuxuryColors.luxuryGray, LuxuryColors.charcoalGray],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: LuxuryColors.silverGray.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: LuxuryColors.platinum,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: LuxuryColors.platinum.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: LuxuryColors.deepBlack,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Motivación Diaria',
                                style: TextStyle(
                                  color: LuxuryColors.deepBlack,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      dailyQuote['quote']!,
                      style: const TextStyle(
                        color: LuxuryColors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 25,
                          decoration: BoxDecoration(
                            color: LuxuryColors.platinum,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '— ${dailyQuote['author']!}',
                            style: const TextStyle(
                              color: LuxuryColors.platinum,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [LuxuryColors.platinum, LuxuryColors.silverGray],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: LuxuryColors.platinum.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: () => _shareQuote(dailyQuote),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: LuxuryColors.deepBlack,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Compartir',
                                      style: TextStyle(
                                        color: LuxuryColors.deepBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [LuxuryColors.platinum, LuxuryColors.silverGray],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: LuxuryColors.platinum.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.business_center,
                      color: LuxuryColors.deepBlack,
                      size: 32,
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MENTALIDAD EMPRESARIAL',
                            style: TextStyle(
                              color: LuxuryColors.deepBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Transformando visiones en realidades',
                            style: TextStyle(
                              color: LuxuryColors.deepBlack,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ===== PÁGINA DE GUARDADAS =====
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuxuryColors.deepBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    LuxuryColors.charcoalGray.withOpacity(0.3),
                    LuxuryColors.luxuryGray.withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                  color: LuxuryColors.silverGray.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.bookmark_border,
                size: 80,
                color: LuxuryColors.lightGray,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Sin frases guardadas',
              style: TextStyle(
                color: LuxuryColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                'Guarda las frases que impulsen tu mentalidad empresarial',
                style: TextStyle(
                  color: LuxuryColors.lightGray,
                  fontSize: 16,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [LuxuryColors.platinum, LuxuryColors.silverGray],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'Próximamente disponible',
                style: TextStyle(
                  color: LuxuryColors.deepBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== PÁGINA DE PERFIL =====
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuxuryColors.deepBlack,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [LuxuryColors.platinum, LuxuryColors.silverGray],
                    ),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: LuxuryColors.charcoalGray,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: LuxuryColors.platinum.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.account_circle,
                    color: LuxuryColors.deepBlack,
                    size: 50,
                  ),
                ),
                const SizedBox(width: 25),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entrepreneur Elite',
                        style: TextStyle(
                          color: LuxuryColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'mindset@luxury.app',
                        style: TextStyle(
                          color: LuxuryColors.lightGray,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [LuxuryColors.platinum, LuxuryColors.silverGray],
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: LuxuryColors.charcoalGray.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: LuxuryColors.platinum.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.verified,
                    color: LuxuryColors.deepBlack,
                    size: 50,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'LUXURY MINDSET ACTIVADO',
                    style: TextStyle(
                      color: LuxuryColors.deepBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Mentalidad empresarial premium con monetización integrada',
                    style: TextStyle(
                      color: LuxuryColors.deepBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: LuxuryColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Publicidad activa - Generando ingresos',
                    style: TextStyle(
                      color: LuxuryColors.lightGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
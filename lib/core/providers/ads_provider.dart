import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/ad_config.dart';

class AdsProvider extends ChangeNotifier {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  
  bool _isBannerAdLoaded = false;
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;

  // IDs de anuncios usando la configuración centralizada
  String get _bannerAdUnitId => AdConfig.bannerAdUnitId;
  String get _interstitialAdUnitId => AdConfig.interstitialAdUnitId;
  String get _rewardedAdUnitId => AdConfig.rewardedAdUnitId;

  BannerAd? get bannerAd => _bannerAd;
  InterstitialAd? get interstitialAd => _interstitialAd;
  RewardedAd? get rewardedAd => _rewardedAd;
  
  bool get isBannerAdLoaded => _isBannerAdLoaded;
  bool get isInterstitialAdLoaded => _isInterstitialAdLoaded;
  bool get isRewardedAdLoaded => _isRewardedAdLoaded;

  void initializeAds() {
    _loadBannerAd();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerAdLoaded = true;
          debugPrint('[Ads] Banner loaded: $_bannerAdUnitId');
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _isBannerAdLoaded = false;
          debugPrint('[Ads] Banner failed to load: $_bannerAdUnitId -> $error');
          notifyListeners();
        },
      ),
    );
    _bannerAd!.load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
          debugPrint('[Ads] Interstitial loaded: $_interstitialAdUnitId');
          _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) => debugPrint('[Ads] Interstitial showed'),
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('[Ads] Interstitial dismissed');
              ad.dispose();
              _interstitialAd = null;
              _isInterstitialAdLoaded = false;
              notifyListeners();
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('[Ads] Interstitial failed to show: $error');
              ad.dispose();
              _interstitialAd = null;
              _isInterstitialAdLoaded = false;
              notifyListeners();
              _loadInterstitialAd();
            },
          );
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          _isInterstitialAdLoaded = false;
          debugPrint('[Ads] Interstitial failed to load: $_interstitialAdUnitId -> $error');
          notifyListeners();
        },
      ),
    );
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedAdLoaded = true;
          debugPrint('[Ads] Rewarded loaded: $_rewardedAdUnitId');
          notifyListeners();
        },
        onAdFailedToLoad: (error) {
          _isRewardedAdLoaded = false;
          debugPrint('[Ads] Rewarded failed to load: $_rewardedAdUnitId -> $error');
          notifyListeners();
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (_interstitialAd != null) {
      debugPrint('[Ads] Showing interstitial');
      await _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdLoaded = false;
      notifyListeners();
      _loadInterstitialAd(); // Cargar el siguiente anuncio
    }
  }

  Future<void> showRewardedAd() async {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _rewardedAd = null;
          _isRewardedAdLoaded = false;
          notifyListeners();
          _loadRewardedAd(); // Cargar el siguiente anuncio
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint('[Ads] Rewarded failed to show: $error');
          ad.dispose();
          _rewardedAd = null;
          _isRewardedAdLoaded = false;
          notifyListeners();
          _loadRewardedAd();
        },
      );
      debugPrint('[Ads] Showing rewarded');
      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          // Aquí puedes dar la recompensa al usuario
          debugPrint('[Ads] Rewarded earned: ${reward.amount} ${reward.type}');
        },
      );
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }
} 
import 'package:firebase_admob/firebase_admob.dart';

class Propaganda {
  static InterstitialAd myInterstitial;
  static int cont = 0;

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'pokémon',
      'games',
      'jogos',
      'freefire',
      'digimon',
      'evolution',
      'evolução',
      'mario',
      'sonic'
    ],
    // childDirected: true, //publico infantil
  );

  static InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-4785348218475505/4449010509",
        // adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myInterstitial?.show();
          }
          if (event == MobileAdEvent.clicked || event == MobileAdEvent.closed) {
            // Future.delayed(Duration(minutes: 1), displayInterstitial());
            myInterstitial.dispose();
          }
        });
  }

  static displayInterstitial() {
    myInterstitial = buildInterstitial()
      ..load()
      ..show();
  }

  static void popUp() {
    // print(cont);
    if (cont == 12) {
      displayInterstitial();
      cont = 0;
    } else
      cont++;
  }

  static void dispose() {
    myInterstitial?.dispose();
  }
}

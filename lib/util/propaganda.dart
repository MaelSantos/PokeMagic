//                   ca-app-pub-4785348218475505~7730065377
// ID do aplicativo: ca-app-pub-4785348218475505~7730065377

// ca-app-pub-4785348218475505/4449010509

import 'package:firebase_admob/firebase_admob.dart';

class Propaganda {
  static BannerAd myBanner;
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
      'evolução'
    ],
    contentUrl: 'https://flutter.io',
    childDirected: true, //publico infantil
    testDevices: <String>[],
  );

  static void startBanner() {
    myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.fullBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.opened) {
          // MobileAdEvent.opened
          // MobileAdEvent.clicked
          // MobileAdEvent.closed
          // MobileAdEvent.failedToLoad
          // MobileAdEvent.impression
          // MobileAdEvent.leftApplication
        }
        print("BannerAd event is $event");
      },
    );
  }

  static void displayBanner() {
    startBanner();
    myBanner
      ..load()
      ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }

  static InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: MobileAdTargetingInfo(testDevices: <String>[]),
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
    print(cont);
    if (cont == 12) {
      displayInterstitial();
      cont = 0;
    } else
      cont++;
  }

  static void dispose() {
    myBanner?.dispose();
    myInterstitial?.dispose();
  }
}

/* import 'package:uni_links3/uni_links.dart';
import 'dart:async';

class DeepLinkHandler {
  StreamSubscription? _linkSubscription;

  /// Dinleyiciyi başlat
  void initialize() {
    _linkSubscription = uriLinkStream.listen(
      (Uri? uri) {
        if (uri != null) {
          _processLink(uri);
        }
      },
      onError: (err) {
        print("Dinleyici hatası: $err");
      },
    );

    _checkInitialLink();
  }

  /// İlk deep link kontrolü
  Future<void> _checkInitialLink() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        _processLink(initialUri);
      }
    } catch (e) {
      print("İlk deep link işlenirken hata: $e");
    }
  }

  /// Gelen linkteki referans kodunu işle
  void _processLink(Uri uri) {
    final refCode = uri.queryParameters['ref'];

    if (refCode != null) {
      print("Referans kodu: $refCode");
      sendReferralCodeToBackend(refCode);
    }
  }

  /// Backend'e referans kodunu gönder
  void sendReferralCodeToBackend(String refCode) {
    print("Backend'e referans kodu iletiliyor: $refCode");
    // HTTP isteğini burada gerçekleştir
  }

  /// Dinleyiciyi temizle
  void dispose() {
    _linkSubscription?.cancel();
  }
}
 */
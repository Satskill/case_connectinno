import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(launchUri);
}

Future<void> openWhatsapp(String phone) async {
  final Uri uri = Uri.parse('https://wa.me/$phone');
  await launchUrl(uri);
}

Future<void> sendEmail(String email) async {
  final Uri uri = Uri(scheme: 'mailto', path: email);
  await launchUrl(uri);
}

import 'package:pixelfield_test/app/view/app_page.dart';
import 'package:pixelfield_test/bootstrap.dart';
import 'package:pixelfield_test/config/flavor_config.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.development);
  await bootstrap(() => const App());
}

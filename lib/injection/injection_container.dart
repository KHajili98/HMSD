import '../main_common.dart';
import 'src/blocs.dart' as blocs;
import 'src/cores.dart' as cores;
import 'src/data_sources.dart' as data_sources;
import 'src/externals.dart' as externals;
import 'src/repositories.dart' as repositories;
import 'src/use_cases.dart' as use_cases;

Future<void> init(Environment environment) async {
  await data_sources.init();
  await cores.init();
  await externals.init(environment);
  await repositories.init();
  await use_cases.init();
  await blocs.init();
}

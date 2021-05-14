import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/mappable_generator.dart';

Builder mappableBuilder(BuilderOptions options) =>
    SharedPartBuilder([MappableGenerator()], 'mappable');

library message_compiler;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/generator.dart';

Builder messageBuilder(BuilderOptions _) =>
  new SharedPartBuilder([CobiGenerator()], "devkit");
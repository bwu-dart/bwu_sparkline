library bwu_sparkline.tool.grind;

import 'package:grinder/grinder.dart';

const sourceDirs = const ['bin', 'lib', 'tool', 'test', 'example'];

main(List<String> args) => grind(args);

@Task('Run analyzer')
analyze() => new PubApp.global('tuneup').run(['check']);

@Task('Runn all tests')
// TODO(zoechi) make test work in Firefox
test() => new PubApp.local('test')
    .run(['-pdartium', /*'-pchrome', '-pfirefox', '-pphantomjs'*/]);

@Task('Check everything')
@Depends(analyze, /*checkFormat,*/ lint, test)
check() {
  run('pub', arguments: ['publish', '-n']);
}

//@Task('Check source code format')
//checkFormat() => checkFormatTask(['.']);

/// format-all - fix all formatting issues
@Task('Fix all source format issues')
formatAll() => new PubApp.global('dart_style').run(['-w']..addAll(sourceDirs),
    script: 'format');

@Task('Run lint checks')
lint() => new PubApp.global('linter')
    .run(['--stats', '-ctool/lintcfg.yaml']..addAll(sourceDirs));

@Task('Build examples to JavaScript')
buildExample() => Pub.build(mode: 'release', directories: ['example']);

library bwu_sparkline.tool.grind;

export 'package:bwu_utils_dev/grinder/default_tasks.dart' hide main;
import 'package:bwu_utils_dev/grinder/default_tasks.dart'
    show
        Depends,
        grind,
        analyzeTask,
        analyzeTaskImpl,
        lintTask,
        lintTaskImpl,
        Task;

main(List<String> args) {
  // Disable analyze becaues it causes too many warnings, needs to be fixed first.
  analyzeTask = ([_]) {
    print('disabled');
  };
  lintTask = () {
    print('disabled');
  };
  grind(args);
}

@Task('Check (manual-only)')
@Depends(analyzeManual, lintManual)
checkManual() {}

@Task('Analyze (manual-only)')
analyzeManual() => analyzeTaskImpl();

@Task('Lint (manual-only)')
lintManual() => lintTaskImpl();

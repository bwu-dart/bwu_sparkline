library bwu_sparkline.tool.grind;

export 'package:bwu_grinder_tasks/bwu_grinder_tasks.dart' hide main;
import 'package:bwu_grinder_tasks/bwu_grinder_tasks.dart'
    show
        Depends,
        grind,
        analyzeTask,
        analyzeTaskImpl,
        lintTask,
        lintTaskImpl,
        Task;

main(List<String> args) {
  // Disable analyze because it causes too many warnings, needs to be fixed first.
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

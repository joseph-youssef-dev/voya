import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));
  for (var file in files) {
    var content = file.readAsStringSync();
    if (content.contains('.withOpacity(')) {
      final newContent = content.replaceAllMapped(
        RegExp(r'\.withOpacity\(([^)]+)\)'),
        (match) => '.withValues(alpha: ${match.group(1)})',
      );
      if (content != newContent) {
        file.writeAsStringSync(newContent);
      }
    }
  }
}

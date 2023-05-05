import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(
    () async {
      Hive.init("myHive");
    },
  );

  test(
    "Hive Create and go",
    () async {
      final box = await Hive.openBox<String>("myHive");
      await box.add("hello");
      expect(box.values.first, "hello");
    },
  );
}

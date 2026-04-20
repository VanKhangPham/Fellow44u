import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fellow4u/main.dart';

void main() {
  testWidgets('Fellow4UApp is created', (WidgetTester tester) async {
    const app = Fellow4UApp();
    expect(app, isA<StatelessWidget>());
  });
}

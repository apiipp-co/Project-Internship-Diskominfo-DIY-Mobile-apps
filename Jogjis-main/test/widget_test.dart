import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:JogjaIstimewa/main.dart';

void main() {
  testWidgets('Aplikasi dapat dijalankan tanpa error', (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const Jogjis());

    // Pastikan aplikasi memiliki MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

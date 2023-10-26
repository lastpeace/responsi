import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsi/ui/tugas_page.dart'; // Gantilah dengan path yang sesuai

void main() {
  testWidgets('Test TugasPage widget', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: TugasPage(),
    ));

    // Verify if the "List Tugas" text is displayed on the screen.
    expect(find.text('List Tugas'), findsOneWidget);

    // Example: Verify if a specific widget is present.
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Example: Perform tap gesture on a widget.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // You can continue with more test cases as needed.

    // Example: Verify if a specific widget is present after the tap.
    expect(find.text('Tugas Form'), findsOneWidget);
  });
}

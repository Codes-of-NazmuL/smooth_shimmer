import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_shimmer/smooth_shimmer.dart';

void main() {
  testWidgets('SmoothShimmer renders child correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothShimmer(
            child: SizedBox(width: 100, height: 20),
          ),
        ),
      ),
    );

    expect(find.byType(SmoothShimmer), findsOneWidget);
    expect(find.byType(ShaderMask), findsOneWidget);
  });

  testWidgets('SmoothShimmer disables shader when enabled is false',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothShimmer(
            enabled: false,
            child: Text('Content'),
          ),
        ),
      ),
    );

    expect(find.text('Content'), findsOneWidget);
    expect(find.byType(ShaderMask), findsNothing);
  });

  testWidgets('SmoothShimmer animates gradient sweep over time',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothShimmer(
            duration: Duration(milliseconds: 1000),
            child: SizedBox(width: 200, height: 50),
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(ShaderMask), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(ShaderMask), findsOneWidget);
  });

  testWidgets('Widget extension .shimmer() works properly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Container(
            width: 150,
            height: 24,
            color: Colors.grey,
          ).shimmer(),
        ),
      ),
    );

    expect(find.byType(SmoothShimmer), findsOneWidget);
    expect(find.byType(ShaderMask), findsOneWidget);
  });
}

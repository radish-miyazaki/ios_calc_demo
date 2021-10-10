import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:calc_clone/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("initialized", () {
    testWidgets('number', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text(0.toString()), findsNWidgets(2));

      for (int i = 1; i < 10; i++) {
        expect(find.text(i.toString()), findsOneWidget);
      }
    });

    testWidgets("character", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text("C"), findsOneWidget);
      expect(find.text("."), findsOneWidget);
      expect(find.text("+"), findsNothing);
      expect(find.text("="), findsNothing);
    });

    testWidgets("icon", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byIcon(CupertinoIcons.plus_slash_minus), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.plus), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.minus), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.multiply), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.percent), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.divide), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.equal), findsOneWidget);
    });
  });

  group("tap", () {
    testWidgets("tap1", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text("1"));
      await tester.pump();
      expect(find.text('1'), findsNWidgets(2));
    });

    testWidgets("calc", (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      Finder resultFinder = find.byKey(Key('txtResult'));
      expect(tester.widget<Text>(resultFinder).data, "0");

      await tester.tap(find.text("1"));
      await tester.tap(find.text("2"));
      await tester.tap(find.text("3"));
      await tester.tap(find.byIcon(CupertinoIcons.add));
      await tester.tap(find.text("1"));
      await tester.tap(find.text("2"));
      await tester.pump();
      expect(tester.widget<Text>(resultFinder).data, "12");

      await tester.tap(find.byIcon(CupertinoIcons.minus));
      await tester.pump();
      expect(tester.widget<Text>(resultFinder).data, "135");

      await tester.tap(find.text("3"));
      await tester.tap(find.text("5"));
      await tester.tap(find.byIcon(CupertinoIcons.equal));
      await tester.pump();
      expect(tester.widget<Text>(resultFinder).data, "100");
    });
  });
}

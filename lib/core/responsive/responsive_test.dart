import 'package:altsome_app/core/responsive/responsive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

Widget _wrap(Size size, Widget child, {double textScale = 1.0}) {
  return MediaQuery(
    data: MediaQueryData(size: size, textScaler: TextScaler.linear(textScale)),
    child: Directionality(textDirection: TextDirection.ltr, child: child),
  );
}

void main() {
  testWidgets('size classes by shortestSide', (tester) async {
    Future<void> pump(Size size) async {
      await tester.pumpWidget(_wrap(
          size,
          Builder(
            builder: (ctx) => Text(AppResponsive.sizeClassOf(ctx).toString()),
          )));
    }

    await pump(const Size(350, 800)); // shortest: 350 -> compact
    expect(find.textContaining('compact'), findsOneWidget);

    await pump(const Size(390, 800)); // 390 -> cozy
    expect(find.textContaining('cozy'), findsOneWidget);

    await pump(const Size(500, 900)); // 500 -> medium
    expect(find.textContaining('medium'), findsOneWidget);

    await pump(const Size(820, 1280)); // 820 -> large
    expect(find.textContaining('large'), findsOneWidget);

    await pump(const Size(900, 1280)); // 900 -> xlarge
    expect(find.textContaining('xlarge'), findsOneWidget);
  });

  testWidgets('text scale clamps between 0.85 and 1.30', (tester) async {
    Future<double> read(double osScale) async {
      double? v;
      await tester.pumpWidget(_wrap(const Size(400, 800), Builder(
        builder: (ctx) {
          v = AppResponsive.textScale(ctx);
          return const SizedBox.shrink();
        },
      ), textScale: osScale));
      return v!;
    }

    expect(await read(0.6), closeTo(0.85, 0.001));
    expect(await read(1.0), closeTo(1.0, 0.001));
    expect(await read(1.6), closeTo(1.30, 0.001));
  });
}

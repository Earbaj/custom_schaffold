// test/custom_scaffold_test.dart
import 'dart:ui' show ImageFilter;
import 'package:custom_scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class TestAssetBundle extends CachingAssetBundle {
  static final Uint8List png1x1 = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin' || key == 'AssetManifest.bin.json') {
      final ByteData data =
          const StandardMessageCodec().encodeMessage(<String, Object?>{})!;
      return data;
    }
    return ByteData.sublistView(png1x1);
  }
}

void main() {
  testWidgets('CustomScaffold displays child widget and AppBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomScaffold(
          appBar: AppBar(title: const Text('Test Title')),
          child: const Text('Hello from Custom Scaffold!'),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Hello from Custom Scaffold!'), findsOneWidget);
  });

  testWidgets('CustomScaffold auto-detects dark and light modes from Theme',
      (WidgetTester tester) async {
    final lightImage = MemoryImage(TestAssetBundle.png1x1);
    final darkImage = MemoryImage(TestAssetBundle.png1x1);

    // Light theme test
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        home: CustomScaffold(
          lightBackgroundImage: lightImage,
          darkBackgroundImage: darkImage,
          child: const Text('Theme Content'),
        ),
      ),
    );

    final containerLight = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image != null,
      ),
    );
    final decorLight = containerLight.decoration as BoxDecoration;
    expect(decorLight.image!.image, lightImage);

    // Dark theme test
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: CustomScaffold(
          lightBackgroundImage: lightImage,
          darkBackgroundImage: darkImage,
          child: const Text('Theme Content'),
        ),
      ),
    );

    final containerDark = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image != null,
      ),
    );
    final decorDark = containerDark.decoration as BoxDecoration;
    expect(decorDark.image!.image, darkImage);
  });

  testWidgets('CustomScaffold supports manual isDark override',
      (WidgetTester tester) async {
    final lightImage = MemoryImage(TestAssetBundle.png1x1);
    final darkImage = MemoryImage(TestAssetBundle.png1x1);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        home: CustomScaffold(
          isDark: true, // Manually force dark background in light theme
          lightBackgroundImage: lightImage,
          darkBackgroundImage: darkImage,
          child: const Text('Override Content'),
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image != null,
      ),
    );
    final decor = container.decoration as BoxDecoration;
    expect(decor.image!.image, darkImage);
  });

  testWidgets('CustomScaffold resolves asset string background',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Offstage(
          offstage: true,
          child: CustomScaffold(
            isDark: false,
            lightBackgroundAsset: 'assets/light_bg.png',
            child: Text('Asset Content'),
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).image != null,
        skipOffstage: false,
      ),
    );
    final decor = container.decoration as BoxDecoration;
    final assetImage = decor.image!.image as AssetImage;
    expect(assetImage.assetName, 'assets/light_bg.png');
  });

  testWidgets('CustomScaffold renders gradient background',
      (WidgetTester tester) async {
    const testGradient = LinearGradient(
      colors: [Colors.red, Colors.blue],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScaffold(
          gradient: testGradient,
          child: Text('Gradient Content'),
        ),
      ),
    );

    final container = tester.widget<Container>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).gradient != null,
      ),
    );
    final decor = container.decoration as BoxDecoration;
    expect(decor.gradient, testGradient);
  });

  testWidgets('CustomScaffold displays loading overlay when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScaffold(
          isLoading: true,
          loadingWidget: Text('Loading Data...'),
          child: Text('Main Content'),
        ),
      ),
    );

    expect(find.text('Loading Data...'), findsOneWidget);
    expect(find.text('Main Content'), findsOneWidget);
  });

  testWidgets('CustomScaffold applies frosted glassmorphism blur effect',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScaffold(
          blurSigma: 12.0,
          blurColor: Colors.black26,
          child: Text('Blurred Content'),
        ),
      ),
    );

    final backdropFinder = find.byType(BackdropFilter);
    expect(backdropFinder, findsOneWidget);

    final backdrop = tester.widget<BackdropFilter>(backdropFinder);
    expect(
      backdrop.filter,
      ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
    );
  });

  testWidgets('CustomScaffold wraps child in SafeArea when useSafeArea is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScaffold(
          useSafeArea: true,
          child: Text('Safe Content'),
        ),
      ),
    );

    expect(find.byType(SafeArea), findsWidgets);
    expect(find.text('Safe Content'), findsOneWidget);
  });

  testWidgets('CustomScaffold drawer and endDrawer work as expected',
      (WidgetTester tester) async {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        home: CustomScaffold(
          scaffoldKey: scaffoldKey,
          drawer: const Drawer(child: Text('Left Drawer')),
          endDrawer: const Drawer(child: Text('Right Drawer')),
          child: const Text('Scaffold Body'),
        ),
      ),
    );

    expect(find.text('Left Drawer'), findsNothing);
    expect(find.text('Right Drawer'), findsNothing);

    // Open drawer via scaffoldKey
    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();
    expect(find.text('Left Drawer'), findsOneWidget);

    // Close drawer
    scaffoldKey.currentState?.closeDrawer();
    await tester.pumpAndSettle();
    expect(find.text('Left Drawer'), findsNothing);

    // Open endDrawer via scaffoldKey
    scaffoldKey.currentState?.openEndDrawer();
    await tester.pumpAndSettle();
    expect(find.text('Right Drawer'), findsOneWidget);
  });

  testWidgets(
      'CustomScaffold backward compatibility with bottomNav and bottomInstance',
      (WidgetTester tester) async {
    // ignore: deprecated_member_use_from_same_package
    await tester.pumpWidget(
      const MaterialApp(
        home: CustomScaffold(
          // ignore: deprecated_member_use_from_same_package
          bottomNav: Text('Legacy Bottom Nav'),
          // ignore: deprecated_member_use_from_same_package
          bottomInstance: false,
          child: Text('Legacy Content'),
        ),
      ),
    );

    expect(find.text('Legacy Bottom Nav'), findsOneWidget);
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.resizeToAvoidBottomInset, false);
  });
}

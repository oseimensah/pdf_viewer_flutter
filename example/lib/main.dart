import 'package:flutter/material.dart';
import 'package:pdf_viewer/pdf_viewer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;
  late PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();
    loadDocument(1);
  }

  loadDocument(value) async {
    setState(() {
      _isLoading = true;
      title = "Loading";
    });
    if (value == 1) {
      document = await PDFDocument.fromURL(
          "https://www.escaux.com/rsrc/EscauxCustomerDocs/DRD_T38Support_AdminGuide/T38_TEST_PAGES.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() {
      title = (value == 1) ? "Loaded From Url" : "Loaded From Assets";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 36),
              ListTile(
                title: const Text('Load from URL'),
                onTap: () {
                  loadDocument(1);
                },
              ),
              ListTile(
                title: const Text('Load from Assets'),
                onTap: () {
                  loadDocument(0);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                ),
        ),
      ),
    );
  }
}

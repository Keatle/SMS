import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DisplayTokensPage extends StatefulWidget {
  @override
  _DisplayTokensPageState createState() => _DisplayTokensPageState();
}

class _DisplayTokensPageState extends State<DisplayTokensPage> {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Map<String, String>? allTokens;

  @override
  void initState() {
    super.initState();
    fetchTokens();
  }

  // Fetch all stored tokens
  void fetchTokens() async {
    allTokens = await storage.readAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Tokens'),
      ),
      body: allTokens == null
          ? Center(child: CircularProgressIndicator())
          : allTokens!.isEmpty
              ? Center(child: Text('No tokens found'))
              : ListView.builder(
                  itemCount: allTokens!.length,
                  itemBuilder: (context, index) {
                    String key = allTokens!.keys.elementAt(index);
                    String value = allTokens![key]!;
                    return ListTile(
                      title: Text(key),
                      subtitle: Text(value),
                    );
                  },
                ),
    );
  }
}

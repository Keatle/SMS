import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'colorProvider.dart'; 
import 'fontSizeProvider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); 
    final fontSizeProvider = Provider.of<FontSizeProvider>(context); 
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          _buildHeader(context), 
          const SizedBox(height: 20), 
          
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Adjust Fonts",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87, 
              ),
            ),
          ),
          const SizedBox(height: 20), 

          
          _buildFontSizeOption(context, 'Small', 12.0, fontSizeProvider),
          _buildFontSizeOption(context, 'Medium', 16.0, fontSizeProvider),
          _buildFontSizeOption(context, 'Large', 20.0, fontSizeProvider),
          
          
          const SizedBox(height: 30),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
           
            child: Text(
              "Adjust Colors",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87, 
              ),
            ),
          ),
          const SizedBox(height: 20), 
          
         
          _buildHeaderColorOption(context, 'Orange Header', const Color.fromARGB(255, 248, 122, 12), colorProvider),
          _buildHeaderColorOption(context, 'Black Header', const Color.fromARGB(214, 1, 1, 1), colorProvider),
        ],
      ),
    );
  }

 
  Widget _buildHeader(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context); 

    return Container(
      width: double.infinity, 
      height: 190.0, 
      color: colorProvider.headerColor, 
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white), 
            onPressed: () {
              Navigator.pop(context); 
            },
          ),
          const SizedBox(height: 10), 
          const Text(
            "Settings",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
             // fontWeight: FontWeight.bold,
              letterSpacing: 1.2, 
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Adjust your preferences",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70, 
              fontStyle: FontStyle.italic, 
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildFontSizeOption(BuildContext context, String title, double size, FontSizeProvider fontSizeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20.0), 
          boxShadow: [
            BoxShadow(
              color: Colors.black12, 
              blurRadius: 4.0, 
              offset: Offset(2, 2), 
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87, 
              fontWeight: FontWeight.w600, 
            ),
          ),
          trailing: Icon(Icons.text_fields, color: Colors.blueAccent), 
          onTap: () {
            fontSizeProvider.setFontSize(size); 
          },
        ),
      ),
    );
  }

  
  Widget _buildHeaderColorOption(BuildContext context, String title, Color color, ColorProvider colorProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20.0), 
          boxShadow: [
            BoxShadow(
              color: Colors.black12, 
              blurRadius: 4.0, 
              offset: Offset(2, 2), 
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87, 
              fontWeight: FontWeight.w600, 
            ),
          ),
          trailing: Icon(Icons.color_lens, color: color), 
          onTap: () {
            colorProvider.setHeaderColor(color); 
          },
        ),
      ),
    );
  }
}

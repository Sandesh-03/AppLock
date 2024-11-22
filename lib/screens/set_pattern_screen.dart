import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class PatternLockScreen extends StatefulWidget {
  @override
  _PatternLockScreenState createState() => _PatternLockScreenState();
}

class _PatternLockScreenState extends State<PatternLockScreen> {
  String? _savedPattern;
  bool _isSettingPattern = true;

  @override
  void initState() {
    super.initState();
    _loadSavedPattern();
  }

  Future<void> _loadSavedPattern() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedPattern = prefs.getString('pattern');
      if (_savedPattern != null) _isSettingPattern = false;
    });
  }

  Future<void> _savePattern(String pattern) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pattern', pattern);
    setState(() {
      _savedPattern = pattern;
      _isSettingPattern = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pattern saved successfully!')),
    );
  }

  void _verifyPattern(String inputPattern) {
    if (_savedPattern == inputPattern) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pattern verified!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect pattern! Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSettingPattern ? 'Set Pattern' : 'Verify Pattern'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PatternLock(
            pointRadius: 10,
            showInput: true,
            onInputComplete: (pattern) {
              final patternString = pattern.join();
              if (_isSettingPattern) {
                _savePattern(patternString);
              } else {
                _verifyPattern(patternString);
              }
            },
            dimension: 3,
            selectedColor: Colors.green,
          ),
        ),
      ),
    );
  }
}

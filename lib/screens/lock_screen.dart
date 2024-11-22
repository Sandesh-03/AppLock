import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:get/get.dart';
import '../executables/controllers/pattern_controller.dart';
import '../services/biometric_service.dart';

class LockScreen extends StatelessWidget {
  final BiometricService _biometricService = BiometricService();
  final PatternController _patternController = Get.find<PatternController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unlock App")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              bool success = await _biometricService.authenticate();
              if (success) {
                Navigator.pop(context, true); // Unlock successful
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Biometric authentication failed")),
                );
              }
            },
            child: const Text("Unlock with Biometrics"),
          ),
          const SizedBox(height: 20),
          PatternLock(
            pointRadius: 10,
            showInput: true,
            selectedColor: Colors.green,
            dimension: 3,
            onInputComplete: (pattern) {
              if (_patternController.validatePattern(pattern.join())) {
                Navigator.pop(context, true); // Unlock successful
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid Pattern")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

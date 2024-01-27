import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class EyesIMRIHelper {
  static const modelPath = 'assets/models/DMEmodel.tflite';

  late final Interpreter interpreter;

  EyesIMRIHelper() {
    loadModel();
  }

  Future<void> loadModel() async {
    final options = InterpreterOptions();
    interpreter = await Interpreter.fromAsset(modelPath, options: options);
  }

  Future<int> inferenceImage(String imagePath) async {
    // Load and preprocess the image
    // Modify this part based on your image preprocessing logic
    print("check Image path$imagePath");
    var imageData = await rootBundle.load("assets/images/without_edema.jpeg");
    var inputImage = img.decodeImage(Uint8List.view(imageData.buffer));

    // Resize the image to match the input shape
    inputImage = img.copyResize(inputImage!, width: 224, height: 224);

    // Convert the image to a 3D tensor
    var inputTensor = List.generate(
      224,
          (y) => List.generate(
        224,
            (x) {
          final pixel = inputImage!.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        },
      ),
    );

    // Run inference
    var input = [inputTensor];
    var output = List.filled(100, 0.0);
    // Assuming 2 classes, modify based on your model output size
    print("input file  ++++ output $output");
    interpreter.run(input, output);

    // Post-process the results
    // Modify this part based on your post-processing logic
    var result = output[0];

    // Return the result (0 or 1)
    return (result > 0.5) ? 1 : 0;
  }

  void close() {
    interpreter.close();
  }
}

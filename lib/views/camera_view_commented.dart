// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_mlkit_commons/google_mlkit_commons.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:swype/views/face_detecttor.dart';
// import 'package:swype/views/painters/new_painter.dart';

// class CameraView extends StatefulWidget {
//   CameraView({
//     Key? key,
//     this.customPaint,
//     this.onImage,
//     this.onCameraFeedReady,
//     this.onDetectorViewModeChanged,
//     this.onCameraLensDirectionChanged,
//     this.initialCameraLensDirection = CameraLensDirection.back,
//   }) : super(key: key);

//   final CustomPaint? customPaint;
//   final Function(InputImage inputImage)? onImage;
//   final VoidCallback? onCameraFeedReady;
//   final VoidCallback? onDetectorViewModeChanged;
//   final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
//   final CameraLensDirection initialCameraLensDirection;

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   Rect? _lastDetectedFaceBoundingBox;
//   final FaceDetector _faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableContours: true,
//       enableLandmarks: true,
//     ),
//   );
//   String? _capturedImagePath;

//   static List<CameraDescription> _cameras = [];
//   CameraController? _controller;
//   int _cameraIndex = -1;
//   double _currentZoomLevel = 1.0;
//   double _minAvailableZoom = 1.0;
//   double _maxAvailableZoom = 1.0;
//   double _minAvailableExposureOffset = 0.0;
//   double _maxAvailableExposureOffset = 0.0;
//   double _currentExposureOffset = 0.0;
//   bool _changingCameraLens = false;
//   int detectedFaceCount = 0;
//   bool _canProcess = true;
//   bool _isBusy = false;
//   CustomPaint? _customPaint;
//   String? _text;
//   var _cameraLensDirection = CameraLensDirection.front;

//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }

//   void _initialize() async {
//     if (_cameras.isEmpty) {
//       _cameras = await availableCameras();
//     }
//     for (var i = 0; i < _cameras.length; i++) {
//       if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
//         _cameraIndex = i;
//         break;
//       }
//     }
//     if (_cameraIndex != -1) {
//       _startLiveFeed();
//     }
//   }

//   @override
//   void dispose() {
//     _stopLiveFeed();
//     super.dispose();
//   }

//   Future<void> _detectFacesOnCapturedImage() async {
//     try {
//       // Perform face detection
//       final faces = await _faceDetector
//           .processImage(InputImage.fromFilePath(_capturedImagePath!));

//       // Display the result
//       setState(() {
//         detectedFaceCount = faces.length;

//         if (faces.isNotEmpty) {
//           // Call the function to load the full image and draw the rectangle
//           _loadFullImageAndShowFaceRectangle(faces.first.boundingBox!);
//         } else {
//           print('No faces detected');
//         }
//       });
//     } catch (e) {
//       print('Error detecting faces on captured image: $e');
//     }
//   }

// // Function to load the full image and draw the rectangle
//   void _loadFullImageAndShowFaceRectangle(Rect boundingBox) async {
//     try {
//       // Load the full image
//       final File capturedImageFile = File(_capturedImagePath!);
//       final Uint8List imageBytes = await capturedImageFile.readAsBytes();
//       final ui.Image fullImage = await decodeImageFromList(imageBytes);

//       // Get the original image dimensions
//       final double _originalImageWidth = fullImage.width.toDouble();
//       final double _originalImageHeight = fullImage.height.toDouble();

//       // Call the function to show the face rectangle
//       _showFaceRectangle(
//           boundingBox, _originalImageWidth, _originalImageHeight);
//     } catch (e) {
//       print('Error loading full image: $e');
//     }
//   }

// // Function to show the face rectangle
//   void _showFaceRectangle(
//       Rect boundingBox, double originalImageWidth, double originalImageHeight) {
//     // Adjustments to the bounding box dimensions
//     final double expandedHeight = boundingBox.height * 1.2; // Increase by 20%
//     final double adjustedTop =
//         boundingBox.top - boundingBox.height * 0.1; // Shift up by 10%

//     setState(() {
//       _customPaint = CustomPaint(
//         painter: FaceDetectorPainterNew(
//           Rect.fromLTRB(
//             boundingBox.left,
//             adjustedTop,
//             boundingBox.right,
//             adjustedTop + expandedHeight,
//           ),
//           originalImageWidth,
//           originalImageHeight,
//         ),
//       );
//     });
//   }

//   getText() {
//     if (detectedFaceCount == 1) {
//       return "Face Detected";
//     } else if (detectedFaceCount == 0) {
//       return "No Face Detetcted";
//     } else {
//       return "More than One Face detected";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: _liveFeedBody());
//   }

//   Widget _liveFeedBody() {
//     if (_cameras.isEmpty) return Container();
//     if (_capturedImagePath != null) {
//       // Display the captured image
//       return Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Image.file(File(_capturedImagePath!)),
//           _customPaint ?? Container(),
//           _saveButton(),
//           Positioned(
//             bottom: 70,
//             left: MediaQuery.of(context).size.width / 2 - 50,
//             child: Text(
//               getText(),
//               style: TextStyle(color: Colors.white),
//             ),
//           )
//         ],
//       );
//     }
//     if (_controller == null) return Container();
//     if (_controller?.value.isInitialized == false) return Container();
//     return Container(
//       color: Colors.black,
//       child: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Center(
//             child: _changingCameraLens
//                 ? Center(
//                     child: const Text('Changing camera lens'),
//                   )
//                 : CameraPreview(
//                     _controller!,
//                     child: widget.customPaint,
//                   ),
//           ),
//           _backButton(),
//           _switchLiveCameraToggle(),
//           _detectionViewModeToggle(),
//           _zoomControl(),
//           _exposureControl(),
//           _captureButton(),
//         ],
//       ),
//     );
//   }

//   Widget _backButton() => Positioned(
//         top: 40,
//         left: 8,
//         child: SizedBox(
//           height: 50.0,
//           width: 50.0,
//           child: FloatingActionButton(
//             heroTag: Object(),
//             onPressed: () => Navigator.of(context).pop(),
//             backgroundColor: Colors.black54,
//             child: Icon(
//               Icons.arrow_back_ios_outlined,
//               size: 20,
//             ),
//           ),
//         ),
//       );

//   Widget _detectionViewModeToggle() => Positioned(
//         bottom: 8,
//         left: 8,
//         child: SizedBox(
//           height: 50.0,
//           width: 50.0,
//           child: FloatingActionButton(
//             heroTag: Object(),
//             onPressed: widget.onDetectorViewModeChanged,
//             backgroundColor: Colors.black54,
//             child: Icon(
//               Icons.photo_library_outlined,
//               size: 25,
//             ),
//           ),
//         ),
//       );

//   Widget _switchLiveCameraToggle() => Positioned(
//         bottom: 8,
//         right: 8,
//         child: SizedBox(
//           height: 50.0,
//           width: 50.0,
//           child: FloatingActionButton(
//             heroTag: Object(),
//             onPressed: _switchLiveCamera,
//             backgroundColor: Colors.black54,
//             child: Icon(
//               Platform.isIOS
//                   ? Icons.flip_camera_ios_outlined
//                   : Icons.flip_camera_android_outlined,
//               size: 25,
//             ),
//           ),
//         ),
//       );

//   Widget _zoomControl() => Positioned(
//         bottom: 16,
//         left: 0,
//         right: 0,
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           child: SizedBox(
//             width: 250,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Slider(
//                     value: _currentZoomLevel,
//                     min: _minAvailableZoom,
//                     max: _maxAvailableZoom,
//                     activeColor: Colors.white,
//                     inactiveColor: Colors.white30,
//                     onChanged: (value) async {
//                       setState(() {
//                         _currentZoomLevel = value;
//                       });
//                       await _controller?.setZoomLevel(value);
//                     },
//                   ),
//                 ),
//                 Container(
//                   width: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text(
//                         '${_currentZoomLevel.toStringAsFixed(1)}x',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//   Widget _exposureControl() => Positioned(
//         top: 40,
//         right: 8,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxHeight: 250,
//           ),
//           child: Column(children: [
//             Container(
//               width: 55,
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: Text(
//                     '${_currentExposureOffset.toStringAsFixed(1)}x',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: RotatedBox(
//                 quarterTurns: 3,
//                 child: SizedBox(
//                   height: 30,
//                   child: Slider(
//                     value: _currentExposureOffset,
//                     min: _minAvailableExposureOffset,
//                     max: _maxAvailableExposureOffset,
//                     activeColor: Colors.white,
//                     inactiveColor: Colors.white30,
//                     onChanged: (value) async {
//                       setState(() {
//                         _currentExposureOffset = value;
//                       });
//                       await _controller?.setExposureOffset(value);
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ]),
//         ),
//       );
//   Widget _captureButton() => Positioned(
//         bottom: 8,
//         left: MediaQuery.of(context).size.width / 2 -
//             25, // Adjust position as needed
//         child: SizedBox(
//           height: 50.0,
//           width: 50.0,
//           child: FloatingActionButton(
//             heroTag: Object(),
//             onPressed: () {
//               _captureImage();
//               //    widget.onImage;
//             },
//             backgroundColor: Colors.black54,
//             child: Icon(
//               Icons.camera,
//               size: 25,
//             ),
//           ),
//         ),
//       );
//   Widget _saveButton() {
//     return Positioned(
//       top: 20,
//       right: 20,
//       child: ElevatedButton(
//         onPressed: () {
//           // Implement logic to save the image
//           _saveCapturedImage();
//         },
//         child: Text("Save"),
//       ),
//     );
//   }

//   Future _startLiveFeed() async {
//     final camera = _cameras[_cameraIndex];
//     _controller = CameraController(
//       camera,
//       // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
//       ResolutionPreset.high,
//       enableAudio: false,
//       imageFormatGroup: Platform.isAndroid
//           ? ImageFormatGroup.nv21
//           : ImageFormatGroup.bgra8888,
//     );
//     _controller?.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       _controller?.getMinZoomLevel().then((value) {
//         _currentZoomLevel = value;
//         _minAvailableZoom = value;
//       });
//       _controller?.getMaxZoomLevel().then((value) {
//         _maxAvailableZoom = value;
//       });
//       _currentExposureOffset = 0.0;
//       _controller?.getMinExposureOffset().then((value) {
//         _minAvailableExposureOffset = value;
//       });
//       _controller?.getMaxExposureOffset().then((value) {
//         _maxAvailableExposureOffset = value;
//       });
//       _controller?.startImageStream(_processCameraImage).then((value) {
//         if (widget.onCameraFeedReady != null) {
//           widget.onCameraFeedReady!();
//         }
//         if (widget.onCameraLensDirectionChanged != null) {
//           widget.onCameraLensDirectionChanged!(camera.lensDirection);
//         }
//         // if (widget.onFaceDetected == true) {
//         //   _captureImage();
//         //  }
//       });
//       setState(() {});
//     });
//   }

//   Future _stopLiveFeed() async {
//     await _controller?.stopImageStream();
//     await _controller?.dispose();
//     _controller = null;
//   }

//   Future _switchLiveCamera() async {
//     setState(() => _changingCameraLens = true);
//     _cameraIndex = (_cameraIndex + 1) % _cameras.length;

//     await _stopLiveFeed();
//     await _startLiveFeed();
//     setState(() => _changingCameraLens = false);
//   }

//   void _processCameraImage(CameraImage image) {
//     final inputImage = _inputImageFromCameraImage(image);
//     if (inputImage == null) return;
//     widget.onImage!(inputImage);
//     //  _processImage(inputImage);
//   }

// // Function to calculate adjusted cropping dimensions based on face rectangle adjustments
//   Rect _calculateAdjustedCropRect(Rect boundingBox) {
//     // Adjustments to the bounding box dimensions
//     final double expandedHeight = boundingBox.height * 1.2; // Increase by 20%
//     final double adjustedTop =
//         boundingBox.top - boundingBox.height * 0.1; // Shift up by 10%

//     // Calculate adjusted cropping dimensions
//     final double left = boundingBox.left;
//     final double top = adjustedTop;
//     final double right = boundingBox.right;
//     final double bottom = adjustedTop + expandedHeight;

//     return Rect.fromLTRB(left, top, right, bottom);
//   }

//   Future<void> _saveCapturedImage() async {
//     if (_capturedImagePath != null) {
//       try {
//         // Load the full image
//         final File capturedImageFile = File(_capturedImagePath!);
//         final Uint8List imageBytes = await capturedImageFile.readAsBytes();
//         final ui.Image fullImage = await decodeImageFromList(imageBytes);

//         // Get the detected faces
//         final List<Face> faces = await _faceDetector
//             .processImage(InputImage.fromFilePath(_capturedImagePath!));

//         // Ensure there is at least one detected face
//         if (faces.isNotEmpty) {
//           // Get the bounding box of the first detected face
//           final Rect boundingBox = faces.first.boundingBox!;

//           // Calculate adjusted cropping dimensions based on face rectangle adjustments
//           final Rect adjustedCropRect = _calculateAdjustedCropRect(boundingBox);

//           // Create a recorder to draw on the image
//           final recorder = ui.PictureRecorder();
//           final canvas = Canvas(recorder);

//           // Draw the cropped region of interest (ROI) from the original image
//           canvas.drawImageRect(
//             fullImage,
//             Rect.fromPoints(
//               Offset(adjustedCropRect.left, adjustedCropRect.top),
//               Offset(adjustedCropRect.right, adjustedCropRect.bottom),
//             ),
//             Rect.fromPoints(
//               Offset.zero,
//               Offset(adjustedCropRect.width, adjustedCropRect.height),
//             ),
//             Paint(),
//           );

//           // Finish recording
//           final recordedImage = await recorder.endRecording().toImage(
//                 adjustedCropRect.width.toInt(),
//                 adjustedCropRect.height.toInt(),
//               );

//           // Convert the recorded image to bytes
//           final ByteData? byteData =
//               await recordedImage.toByteData(format: ui.ImageByteFormat.png);
//           final List<int> croppedImageBytes = byteData!.buffer.asUint8List();

//           // Get the app's local directory
//           final appDir = await getApplicationDocumentsDirectory();

//           // Generate a unique filename for the saved image
//           final uniqueFileName = DateTime.now().toIso8601String() + ".png";

//           // Build the destination path
//           final destinationPath = appDir.path + "/" + uniqueFileName;

//           // Write the cropped image bytes to the destination path
//           await File(destinationPath).writeAsBytes(croppedImageBytes);

//           // Optionally, you can display a message or perform other actions after saving
//           // For example: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image saved!")));
//         } else {
//           print("No face detected in the captured image.");
//           // Handle the case where no face is detected
//         }
//       } catch (e) {
//         // Handle errors during the save operation
//         print("Error saving image: $e");
//       }
//     }
//   }

//   void _captureImage() async {
//     try {
//       final XFile? imageFile = await _controller?.takePicture();
//       if (imageFile != null) {
//         _stopLiveFeed(); // Stop live feed after capturing
//         setState(() {
//           _capturedImagePath = imageFile.path;
//         });
//         await _detectFacesOnCapturedImage();
//       }
//     } catch (e) {
//       print('Error capturing image: $e');
//     }
//   }

//   final _orientations = {
//     DeviceOrientation.portraitUp: 0,
//     DeviceOrientation.landscapeLeft: 90,
//     DeviceOrientation.portraitDown: 180,
//     DeviceOrientation.landscapeRight: 270,
//   };

//   InputImage? _inputImageFromCameraImage(CameraImage image) {
//     if (_controller == null) return null;

//     final camera = _cameras[_cameraIndex];
//     final sensorOrientation = camera.sensorOrientation;
//     // print(
//     //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
//     InputImageRotation? rotation;
//     if (Platform.isIOS) {
//       rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
//     } else if (Platform.isAndroid) {
//       var rotationCompensation =
//           _orientations[_controller!.value.deviceOrientation];
//       if (rotationCompensation == null) return null;
//       if (camera.lensDirection == CameraLensDirection.front) {
//         // front-facing
//         rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
//       } else {
//         // back-facing
//         rotationCompensation =
//             (sensorOrientation - rotationCompensation + 360) % 360;
//       }
//       rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
//       // print('rotationCompensation: $rotationCompensation');
//     }
//     if (rotation == null) return null;
//     // print('final rotation: $rotation');

//     // get image format
//     final format = InputImageFormatValue.fromRawValue(image.format.raw);
//     // validate format depending on platform
//     // only supported formats:
//     // * nv21 for Android
//     // * bgra8888 for iOS
//     if (format == null ||
//         (Platform.isAndroid && format != InputImageFormat.nv21) ||
//         (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

//     // since format is constraint to nv21 or bgra8888, both only have one plane
//     if (image.planes.length != 1) return null;
//     final plane = image.planes.first;

//     // compose InputImage using bytes
//     return InputImage.fromBytes(
//       bytes: plane.bytes,
//       metadata: InputImageMetadata(
//         size: Size(image.width.toDouble(), image.height.toDouble()),
//         rotation: rotation, // used only in Android
//         format: format, // used only in iOS
//         bytesPerRow: plane.bytesPerRow, // used only in iOS
//       ),
//     );
//   }
// }

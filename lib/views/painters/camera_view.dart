// ignore_for_file: prefer_const_constructors, empty_catches, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swype/constants/color_file.dart';
import 'package:swype/isar_services/isar_service.dart';
import 'package:swype/models/add_activity.dart';
import 'package:swype/models/check_in_model.dart';
import 'package:swype/services/api_services.dart';
import 'package:swype/views/face_detecttor.dart';
import 'package:swype/views/home_view.dart';
import 'package:swype/views/new_home.dart';
import 'package:swype/views/painters/new_painter.dart';

import 'package:geolocator/geolocator.dart';
import 'package:swype/widgets/app_large_text.dart';
import 'package:swype/widgets/app_text.dart';

class CameraView extends StatefulWidget {
  CameraView({
    Key? key,
    this.customPaint,
    this.onImage,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.serviceEnabled,
    this.locationId,
    this.acessToken,
    this.lat,
    this.long,
    this.type,
    this.locationName,
  }) : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage)? onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;
  bool? serviceEnabled;
  int? locationId;
  final String? acessToken;
  double? lat;
  double? long;
  String? locationName;
  int? type = 2;
  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  String typeCh = "2";
  late String lat;
  late String long;
  Rect? _lastDetectedFaceBoundingBox;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  String? _capturedImagePath;

  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;
  int detectedFaceCount = 0;
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  int? checoutType = 0;
  var _cameraLensDirection = CameraLensDirection.front;
  bool isLoading = false;
  String getCurrentUserEmail = '';

  @override
  void initState() {
    super.initState();

    print("the acess token is from cv:  ${widget.acessToken}");
    print("the location id is from cv:  ${widget.locationId}");
    print("the lat is from cv:  ${widget.lat}");
    print("the long is from cv:  ${widget.long}");
    print("the type is from cv:  ${widget.type}");
    print("now you are in initsate of camera view");
    print("the current user email is $getCurrentUserEmail");
    getCurrentUser();
    _initialize();
  }

  getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        getCurrentUserEmail = prefs.getString('email')!;
      });
      print("the current user email from function is $getCurrentUserEmail");
    }
  }

  void _initialize() async {
    if (mounted) {
      if (_cameras.isEmpty) {
        _cameras = await availableCameras();
      }
      for (var i = 0; i < _cameras.length; i++) {
        if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
          _cameraIndex = i;
          break;
        }
      }
      if (_cameraIndex != -1) {
        _startLiveFeed();
      }
    }
  }

  Future<Position> _getCurrentLocation() async {
    widget.serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (widget.serviceEnabled == false) {
      return Future.error("Enable Location");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permisiion denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return HomeView();
      }));
      return Future.error("Permission denied forever");
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Future<void> _detectFacesOnCapturedImage() async {
    try {
      // Perform face detection
      final faces = await _faceDetector
          .processImage(InputImage.fromFilePath(_capturedImagePath!));

      // Display the result
      setState(() {
        detectedFaceCount = faces.length;

        if (faces.isNotEmpty) {
          // Call the function to load the full image and draw the rectangle
          _loadFullImageAndShowFaceRectangle(faces.first.boundingBox!);
        } else {
          print('No faces detected');
        }
      });
    } catch (e) {
      print('Error detecting faces on captured image: $e');
    }
  }

// Function to load the full image and draw the rectangle
  void _loadFullImageAndShowFaceRectangle(Rect boundingBox) async {
    try {
      // Load the full image
      final File capturedImageFile = File(_capturedImagePath!);
      final Uint8List imageBytes = await capturedImageFile.readAsBytes();
      final ui.Image fullImage = await decodeImageFromList(imageBytes);

      // Get the original image dimensions
      final double _originalImageWidth = fullImage.width.toDouble();
      final double _originalImageHeight = fullImage.height.toDouble();

      // Call the function to show the face rectangle
      _showFaceRectangle(
          boundingBox, _originalImageWidth, _originalImageHeight);
    } catch (e) {
      print('Error loading full image: $e');
    }
  }

  void _showFaceRectangle(
      Rect boundingBox, double originalImageWidth, double originalImageHeight) {
    setState(() {
      _customPaint = CustomPaint(
        painter:
            NewPainter(boundingBox, originalImageWidth, originalImageHeight),
      );
    });
  }

// Function to show the face rectangle
  // void _showFaceRectangle(
  //     Rect boundingBox, double originalImageWidth, double originalImageHeight) {
  //   // Adjustments to the bounding box dimensions
  //   final double expandedHeight = boundingBox.height * 1.2; // Increase by 20%
  //   final double adjustedTop =
  //       boundingBox.top - boundingBox.height * 0.1; // Shift up by 10%

  //   setState(() {
  //     _customPaint = CustomPaint(
  //       painter: NewPainter(
  //         Rect.fromLTRB(
  //           boundingBox.left,
  //           adjustedTop,
  //           boundingBox.right,
  //           adjustedTop + expandedHeight,
  //         ),
  //         originalImageWidth,
  //         originalImageHeight,
  //       ),
  //     );
  //   });
  // }

  getText() {
    if (detectedFaceCount == 1) {
      return "Face Detected";
    } else if (detectedFaceCount == 0) {
      return "No Face Detetcted";
    } else {
      return "More than One Face detected";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        // left: 20,

        left: 0.0487 * screenWidth,
        // right: 20,
        right: 0.0487 * screenWidth,
        // top: 25,
        top: 0.03406 * screenHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              // color: Colors.amber,
              child: Row(
                //  crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/fng.svg",
                    // height: 50,
                    // width: 50,

                    height: 0.0681 * screenHeight,
                    width: 0.01217 * screenWidth,
                  ),
                  AppLargeText(text: "Swype")
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              // left: 5,

              left: 0.0122 * screenWidth,
            ),
            child: AppText(text: "Seamless Attendance Management"),
          ),
          SizedBox(
            // height: 24,

            height: 0.0327 * screenHeight,
          ),
          Expanded(child: _liveFeedBody()),
          SizedBox(
            // height: 24,

            height: 0.0327 * screenHeight,
          ),
        ],
      ),
    ));
  }

  Widget _liveFeedBody() {
    final ApiServices loginService = ApiServices();
    final screenWidth = MediaQuery.of(context).size.width;
    if (_cameras.isEmpty) return Container();
    if (_capturedImagePath != null) {
      // Display the captured image
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: FileImage(File(_capturedImagePath!)),
                  fit: BoxFit.cover,
                )),
            // child: Image.file(
            //   File(_capturedImagePath!),
            // ),
          ),
          _customPaint ?? Container(),
          // _saveButton(),
          // Positioned(
          //   bottom: 70,
          //   // left: MediaQuery.of(context).size.width / 3,
          //   left: 0,
          //   right: 0,
          //   child: Text(
          //     getText(),
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          Positioned(
            bottom: 0,

            // left: MediaQuery.of(context).size.width / 2 - 50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width:
                  MediaQuery.of(context).size.width - 0.0487 * screenWidth * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: widget.type == 1
                    ? Theme.of(context).colorScheme.inverseSurface
                    : Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return SpinKitSpinningLines(color: primaryBlueColor);
                    },
                  );
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  print(
                      "the acess token is from checkin is:  ${widget.acessToken}");
                  print(
                      "the location id is from checkin is:  ${widget.locationId}");
                  final base64ImageString = await _saveCapturedImage();
                  // print(
                  // // "the base64 image is from checkin button $base64ImageString ");
                  // print("the lat is from checkin button ${widget.lat} ");
                  // print("the long is from checkin button ${widget.long} ");
                  // print("the type is from checkin button ${widget.type} ");
                  // print("typeCh is${widget.type}");
                  // print("now we are going to call api");
                  try {
                    if (widget.lat != null && widget.long != null) {
                      CheckInApiModel response = await loginService.checkinApi(
                        widget.acessToken!,
                        widget.locationId!,
                        widget.locationName!,
                        widget.lat!,
                        widget.long!,
                        widget.type!,
                        getCurrentUserEmail,
                        // 2,
                        base64ImageString!,
                      );

                      print(
                          "the response is  form camera view${response.success}");
                      // ...
                      // rest of your code ...
                    } else {
                      print("Latitude and/or longitude is null");
                    }
                    // if (response.success!) {
                    //   // Call addActivityApi function here
                    //   AddActivityModel activityResponse =
                    //       await loginService.addActivityApi(
                    //     widget.acessToken!,
                    //     1805, // replace with actual userId
                    //     "2023-10-30", // replace with actual date
                    //     "2024-02-10", // replace with actual time
                    //     3, // replace with actual location
                    //     1, // replace with actual type
                    //   );

                    //   print(
                    //       "the response for add activity api is ${activityResponse.success}");
                    // }
                  } catch (e) {}
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop(); // Dismiss the dialog
                  // Get.offAll(() => NewHomeView(
                  //       isActivityAdded: true,
                  //       isCheckingIn: widget.type == 1 ? true : false,
                  //       isCheckingOut: widget.type == 2 ? true : false,
                  //     ));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewHomeView(
                        isActivityAdded: true,
                        isCheckingIn: widget.type == 1 ? true : false,
                        isCheckingOut: widget.type == 2 ? true : false,
                      ),
                    ),
                    (Route<dynamic> route) => false,
                  );
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NewHomeView(
                  //       isActivityAdded: true,
                  //       isCheckingIn: widget.type == 1 ? true : false,
                  //       isCheckingOut: widget.type == 2 ? true : false,
                  //     ),
                  //   ),
                  // );

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomeView()));
                },
                child: Center(
                  child: AppText(
                    text: widget.type == 1 ? "CHECK-IN" : "Check-Out",
                    color: buttonTextWhiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: _changingCameraLens
                ? Center(
                    child: const Text('Changing camera lens'),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CameraPreview(
                      _controller!,
                      child: widget.customPaint,
                    ),
                  ),
          ),
          // _backButton(),
          // _switchLiveCameraToggle(),
          // _detectionViewModeToggle(),
          // _zoomControl(),
          // _exposureControl(),
          _captureButton(),
        ],
      ),
    );
  }

  Widget _backButton() => Positioned(
        top: 40,
        left: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: () => Navigator.of(context).pop(),
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
            ),
          ),
        ),
      );

  Widget _detectionViewModeToggle() => Positioned(
        bottom: 8,
        left: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: widget.onDetectorViewModeChanged,
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.photo_library_outlined,
              size: 25,
            ),
          ),
        ),
      );

  Widget _switchLiveCameraToggle() => Positioned(
        bottom: 8,
        right: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: _switchLiveCamera,
            backgroundColor: Colors.black54,
            child: Icon(
              Platform.isIOS
                  ? Icons.flip_camera_ios_outlined
                  : Icons.flip_camera_android_outlined,
              size: 25,
            ),
          ),
        ),
      );

  Widget _zoomControl() => Positioned(
        top: 80,
        left: 8,
        child: RotatedBox(
          quarterTurns: 3,
          child: SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Slider(
                    value: _currentZoomLevel,
                    min: _minAvailableZoom,
                    max: _maxAvailableZoom,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentZoomLevel = value;
                      });
                      await _controller?.setZoomLevel(value);
                    },
                  ),
                ),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${_currentZoomLevel.toStringAsFixed(1)}x',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _exposureControl() => Positioned(
        top: 80,
        right: 8,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 250,
          ),
          child: Column(children: [
            Container(
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${_currentExposureOffset.toStringAsFixed(1)}x',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  height: 30,
                  child: Slider(
                    value: _currentExposureOffset,
                    min: _minAvailableExposureOffset,
                    max: _maxAvailableExposureOffset,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      if (mounted) {
                        setState(() {
                          _currentExposureOffset = value;
                        });
                      }
                      await _controller?.setExposureOffset(value);
                    },
                  ),
                ),
              ),
            )
          ]),
        ),
      );
  Widget _captureButton() => Positioned(
        // bottom: 20,
        bottom: MediaQuery.of(context).size.height * 0.03, // 5% from the bottom

        left: 0,
        right: 0,
        // left: MediaQuery.of(context).size.width / 2 -
        //     25, // Adjust position as needed
        child: SizedBox(
          height:
              MediaQuery.of(context).size.width * 0.15, // 10% of screen width
          width:
              MediaQuery.of(context).size.width * 0.15, // 10% of screen width

          // height: 50.0,
          // width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: () {
              _captureImage();
              //    widget.onImage;
            },
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.camera,
              // size: 25,
              size:
                  MediaQuery.of(context).size.width * 0.1, // 5% of screen width

              color: Colors.white,
            ),
          ),
        ),
      );
  Widget _saveButton() {
    return Positioned(
      top: 20,
      right: 20,
      child: ElevatedButton(
        onPressed: () {
          // Implement logic to save the image
          _saveCapturedImage();
        },
        child: Text("Save"),
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
        // if (widget.onFaceDetected == true) {
        //   _captureImage();
        //  }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage!(inputImage);
    //  _processImage(inputImage);
  }

  Future<String?> _saveCapturedImage() async {
    if (_capturedImagePath != null) {
      try {
        // Get the detected faces
        final List<Face> faces = await _faceDetector
            .processImage(InputImage.fromFilePath(_capturedImagePath!));

        // Ensure there is at least one detected face
        if (faces.isNotEmpty) {
          // Use the bounding box from detectFacesOnCapturedImage
          final Rect boundingBox = faces.first.boundingBox!;

          // Load the full image
          final File capturedImageFile = File(_capturedImagePath!);
          final Uint8List imageBytes = await capturedImageFile.readAsBytes();
          final ui.Image fullImage = await decodeImageFromList(imageBytes);

          // Create a recorder to draw on the image
          final recorder = ui.PictureRecorder();
          final canvas = Canvas(recorder);

          // Crop the image using the bounding box
          final double left = boundingBox.left.toDouble();
          final double top = boundingBox.top.toDouble();
          final double width = boundingBox.width.toDouble();
          final double height = boundingBox.height.toDouble();

          // Draw the cropped region of interest (ROI) from the original image
          canvas.drawImageRect(
            fullImage,
            Rect.fromPoints(
              Offset(left, top),
              Offset(left + width, top + height),
            ),
            Rect.fromPoints(Offset.zero, Offset(width, height)),
            Paint(),
          );

          // Finish recording
          final recordedImage = await recorder.endRecording().toImage(
                width.toInt(),
                height.toInt(),
              );

          // Convert the recorded image to bytes
          final ByteData? byteData =
              await recordedImage.toByteData(format: ui.ImageByteFormat.png);

          if (byteData != null) {
            final List<int> croppedImageBytes = byteData.buffer.asUint8List();

            final String base64Image = base64Encode(croppedImageBytes);

            // Get the app's local directory
            final appDir = await getApplicationDocumentsDirectory();

            // Generate a unique filename for the saved image
            final uniqueFileName = DateTime.now().toIso8601String() + ".txt";

            // Build the destination path
            final destinationPath = appDir.path + "/" + uniqueFileName;

            // Write the cropped image bytes to the destination path
            // await File(destinationPath).writeAsBytes(croppedImageBytes);
            await File(destinationPath).writeAsString(base64Image);
            print("the base64 image is $base64Image");

            // Return the base64 string.
            return base64Image;
          }
        } else {
          print("No face detected in the captured image.");
          // Handle the case where no face is detected
        }
      } catch (e) {
        // Handle errors during the save operation
        print("Error saving image: $e");
      }
    }

    // Return null if no face is detected or if there's an error.
    return null;
  }

  void _captureImage() async {
    if (mounted) {
      try {
        final XFile? imageFile = await _controller?.takePicture();
        if (imageFile != null) {
          _stopLiveFeed(); // Stop live feed after capturing
          setState(() {
            _capturedImagePath = imageFile.path;
          });
          _getCurrentLocation().then(
            (value) {
              // lat = '${value.latitude}';
              // long = '${value.longitude}';
              setState(() {
                print("Lattitude value : $lat");

                print("Lattitude value : $long");
              });
            },
          );
          await _detectFacesOnCapturedImage();
        }
      } catch (e) {
        print('Error capturing image: $e');
      }
    }
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}

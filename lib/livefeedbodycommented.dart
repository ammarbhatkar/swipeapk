
  // Widget _liveFeedBody() {
  //   if (_cameras.isEmpty) return Container();
  //   if (_capturedImagePath != null) {
  //     // Display the captured image
  //     return Stack(
  //       fit: StackFit.expand,
  //       children: <Widget>[
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10.0),
  //             image: DecorationImage(
  //               image: FileImage(File(_capturedImagePath!)),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         // _saveButton(),
  //         Positioned(
  //           bottom: 70,
  //           left: MediaQuery.of(context).size.width / 2 - 70,
  //           child: Text(
  //             getText(),
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 0,

  //           // left: MediaQuery.of(context).size.width / 2 - 50,
  //           child: Container(
  //             padding: EdgeInsets.symmetric(vertical: 10),
  //             width: MediaQuery.of(context).size.width - 40,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(10),
  //                 bottomRight: Radius.circular(10),
  //               ),
  //               color: primaryBlueColor,
  //             ),
  //             child: Center(
  //               child: AppText(
  //                 text: "CHECK-IN",
  //                 color: buttonTextWhiteColor,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  //   if (_controller == null) return Container();
  //   if (_controller?.value.isInitialized == false) return Container();
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     // color: Colors.black,
  //     child: Stack(
  //       fit: StackFit.expand,
  //       children: <Widget>[
  //         Center(
  //           child: _changingCameraLens
  //               ? Center(
  //                   child: const Text('Changing camera lens'),
  //                 )
  //               : ClipRRect(
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: CameraPreview(
  //                     _controller!,
  //                     child: widget.customPaint,
  //                   ),
  //                 ),
  //         ),
  //         // _backButton(),
  //         _switchLiveCameraToggle(),
  //         _detectionViewModeToggle(),
  //         _zoomControl(),
  //         _exposureControl(),
  //         _captureButton(),
  //       ],
  //     ),
  //   );
  // }

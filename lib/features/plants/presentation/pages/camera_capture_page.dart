import 'dart:io';
import 'dart:developer' as developer;
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/ui_constants.dart';
import 'plant_editor_page.dart';

class CameraCapturePage extends StatefulWidget {
  final String herbariumId;

  const CameraCapturePage({super.key, required this.herbariumId});

  @override
  State<CameraCapturePage> createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> with SingleTickerProviderStateMixin {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isReady = false;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: UiConstants.defaultAnimationDuration);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        if (mounted) Navigator.pop(context);
        return;
      }
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        final backCamera = _cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras.first,
        );
        
        _controller = CameraController(
          backCamera, 
          ResolutionPreset.max, 
          enableAudio: false,
        );
        
        await _controller!.initialize();

        if (!mounted) return;
        setState(() {
          _isReady = true;
        });
      }
    } catch (e) {
      developer.log('Failed to initialize camera: $e', name: 'CameraCapturePage');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      _animController.forward().then((_) => _animController.reverse());
      final XFile picture = await _controller!.takePicture();
      
      final File rotatedImage = await FlutterExifRotation.rotateImage(path: picture.path);

      if (!mounted) return;
      
      final result = await Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (_) => PlantEditorPage(
            photoPath: rotatedImage.path, 
            herbariumId: widget.herbariumId,
          ),
        ),
      );

      if (!mounted) return;
      if (result == true) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${l10n.cameraError}$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (!_isReady || _controller == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 16),
              Text(l10n.cameraInit, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, shadows: [Shadow(color: Colors.black54, blurRadius: 10)]),
        title: Text(l10n.scannerTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, shadows: [Shadow(color: Colors.black54, blurRadius: 10)])),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Transform.scale(
              scale: (1 / _controller!.value.aspectRatio) / deviceRatio,
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            ),
          ),
          
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Container(
                color: Colors.white.withOpacity(_animController.value),
              );
            },
          ),

          Center(
            child: Container(
              width: size.width * UiConstants.cameraFocusBoxSizeRatio,
              height: size.width * UiConstants.cameraFocusBoxSizeRatio,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                borderRadius: BorderRadius.circular(UiConstants.cameraFocusBoxCornerBorder),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePicture,
                child: Container(
                  height: UiConstants.cameraOuterRingSize,
                  width: UiConstants.cameraOuterRingSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: UiConstants.cameraOuterRingBorder),
                  ),
                  child: Center(
                    child: Container(
                      height: UiConstants.cameraInnerCircleSize,
                      width: UiConstants.cameraInnerCircleSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

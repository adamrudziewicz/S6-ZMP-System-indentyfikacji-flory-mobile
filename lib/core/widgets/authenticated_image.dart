import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/api/api_constants.dart';

class AuthenticatedImage extends StatefulWidget {
  final String filename;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AuthenticatedImage({
    Key? key,
    required this.filename,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  @override
  State<AuthenticatedImage> createState() => _AuthenticatedImageState();
}

class _AuthenticatedImageState extends State<AuthenticatedImage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _storage.read(key: 'jwt_token');
    if (mounted) {
      setState(() {
        _token = token;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final String imageUrl = '${ApiConstants.baseUrl}/photos/${widget.filename}';
    final Map<String, String> headers = {};
    if (_token != null && _token!.isNotEmpty) {
      final cleanToken = _token!.startsWith('Bearer ') ? _token!.substring(7) : _token!;
      headers['Authorization'] = 'Bearer $cleanToken';
    }

    return Image.network(
      imageUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      headers: headers,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      },
    );
  }
}

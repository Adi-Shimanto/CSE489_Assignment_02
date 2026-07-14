import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageScaleScreen extends StatefulWidget {
  const ImageScaleScreen({super.key});

  @override
  State<ImageScaleScreen> createState() => _ImageScaleScreenState();
}

class _ImageScaleScreenState extends State<ImageScaleScreen> {
  final String _imageUrl = 'https://picsum.photos/800/600?random=1';
  double _scale = 1.0;

  void _zoomIn() {
    setState(() {
      if (_scale < 4.0) _scale = (_scale + 0.2).clamp(0.5, 4.0);
    });
  }

  void _zoomOut() {
    setState(() {
      if (_scale > 0.5) _scale = (_scale - 0.2).clamp(0.5, 4.0);
    });
  }

  void _resetZoom() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Scale'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Get the actual available width and height
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight - 200; // Leave space for controls

          return Column(
            children: [
              // Image Container with explicit size
              Container(
                width: width,
                height: height,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Transform.scale(
                      scale: _scale,
                      child: Container(
                        width: width - 32,
                        height: height - 32,
                        child: CachedNetworkImage(
                          imageUrl: _imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline, size: 50, color: Colors.red),
                                SizedBox(height: 10),
                                Text('Failed to load image'),
                                Text(
                                  'Check your internet connection',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Zoom Controls
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Zoom: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${(_scale * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _zoomOut,
                          icon: const Icon(Icons.zoom_out),
                          label: const Text('Zoom Out'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _resetZoom,
                          icon: const Icon(Icons.restart_alt),
                          label: const Text('Reset'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _zoomIn,
                          icon: const Icon(Icons.zoom_in),
                          label: const Text('Zoom In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
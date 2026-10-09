import 'package:flutter/material.dart';

class Task82ImagePreview extends StatelessWidget {
  const Task82ImagePreview({super.key});

  final List<String> flowerImages = const [
    'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=500',
    'https://images.unsplash.com/photo-1494972308805-463bc619d34e?w=500',
    'https://images.unsplash.com/photo-1499002238440-d264edd596ec?w=500',
    'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=500',
    'https://images.unsplash.com/photo-1462275646964-a0e3386b89fa?w=500',
    'https://images.unsplash.com/photo-1508610048659-a06b669e3321?w=500',
  ];

  void openImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
            ),
            body: Center(
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 60,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flower Preview 🌷'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: flowerImages.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                openImage(context, flowerImages[index]);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  flowerImages[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.local_florist,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';

/// Widget for displaying a horizontally scrollable thumbnail gallery.
///
/// This widget implements AC-6 from User Story 2:
/// - Horizontally scrollable thumbnail strip
/// - Current image highlighted
/// - Tap to navigate to specific image
/// - Auto-scrolls to keep current thumbnail visible
class SlideshowThumbnailGallery extends StatefulWidget {
  /// The list of images to display as thumbnails.
  final List<BreedImageModel> images;

  /// The index of the currently displayed image.
  final int currentIndex;

  /// Callback for when a thumbnail is tapped.
  final ValueChanged<int> onThumbnailTapped;

  /// Creates an instance of [SlideshowThumbnailGallery].
  const SlideshowThumbnailGallery({
    required this.images,
    required this.currentIndex,
    required this.onThumbnailTapped,
    super.key,
  });

  @override
  State<SlideshowThumbnailGallery> createState() =>
      _SlideshowThumbnailGalleryState();
}

class _SlideshowThumbnailGalleryState extends State<SlideshowThumbnailGallery> {
  final ScrollController _scrollController = ScrollController();
  static const double thumbnailSize = 80.0;
  static const double thumbnailSpacing = 8.0;

  @override
  void didUpdateWidget(SlideshowThumbnailGallery oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Auto-scroll to current thumbnail when index changes
    if (oldWidget.currentIndex != widget.currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentIndex();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thumbnailSize,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.images.length,
        itemBuilder: (BuildContext context, int index) {
          final BreedImageModel image = widget.images[index];
          final bool isSelected = index == widget.currentIndex;

          return Padding(
            padding: const EdgeInsets.only(right: thumbnailSpacing),
            child: GestureDetector(
              onTap: () => widget.onThumbnailTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: thumbnailSize,
                height: thumbnailSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: isSelected
                      ? <BoxShadow>[
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    children: <Widget>[
                      // Thumbnail image
                      CachedNetworkImage(
                        imageUrl: image.imageUrl,
                        width: thumbnailSize,
                        height: thumbnailSize,
                        fit: BoxFit.cover,
                        placeholder: (BuildContext context, String url) =>
                            Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                        errorWidget:
                            (BuildContext context, String url, dynamic error) =>
                                Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                ),
                      ),

                      // Favorite indicator
                      if (image.isFavorite)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 12,
                            ),
                          ),
                        ),

                      // Dimming overlay for non-selected thumbnails
                      if (!isSelected)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Scrolls the thumbnail gallery to keep the current thumbnail visible.
  void _scrollToCurrentIndex() {
    if (!_scrollController.hasClients) return;

    const double itemWidth = thumbnailSize + thumbnailSpacing;
    final double targetOffset = widget.currentIndex * itemWidth;
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;
    final double viewportWidth = _scrollController.position.viewportDimension;

    // Calculate the offset to center the current thumbnail
    final double centeredOffset =
        targetOffset - (viewportWidth / 2) + (thumbnailSize / 2);
    final double clampedOffset = centeredOffset.clamp(0.0, maxScrollExtent);

    _scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

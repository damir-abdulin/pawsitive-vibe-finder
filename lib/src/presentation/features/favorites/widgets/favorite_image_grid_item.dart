import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../domain/models/dog_model.dart';
import '../../../theme/colors.dart';

/// A grid item widget for displaying a favorite dog image.
class FavoriteImageGridItem extends StatefulWidget {
  /// Creates a [FavoriteImageGridItem].
  const FavoriteImageGridItem({
    required this.dog,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onImageTap,
    super.key,
  });

  /// The dog model to display.
  final DogModel dog;

  /// Whether this image is currently favorited.
  final bool isFavorite;

  /// Callback when the favorite button is tapped.
  final VoidCallback onFavoriteToggle;

  /// Callback when the image is tapped.
  final VoidCallback onImageTap;

  @override
  State<FavoriteImageGridItem> createState() => _FavoriteImageGridItemState();
}

class _FavoriteImageGridItemState extends State<FavoriteImageGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onImageTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // Dog image
                    Hero(
                      tag: widget.dog.imageUrl,
                      child: CachedNetworkImage(
                        imageUrl: widget.dog.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (BuildContext context, String url) =>
                            Container(
                              color: AppColors.secondaryBackground,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                        errorWidget:
                            (BuildContext context, String url, dynamic error) =>
                                Container(
                                  color: AppColors.secondaryBackground,
                                  child: const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: AppColors.error,
                                      size: 32,
                                    ),
                                  ),
                                ),
                      ),
                    ),
                    // Heart button overlay
                    Positioned(top: 8, right: 8, child: _buildHeartButton()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeartButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onFavoriteToggle,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.isFavorite
                  ? const Color(0xFFE92933)
                  : const Color(0xFF9CA3AF),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

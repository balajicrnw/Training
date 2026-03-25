import 'package:flutter/material.dart';

/// A single step in the tutorial overlay.
class TooltipStep {
  final GlobalKey targetKey;
  final String title;
  final String description;

  const TooltipStep({
    required this.targetKey,
    required this.title,
    required this.description,
  });
}

/// Shows a step-by-step spotlight overlay for the given [steps].
/// Call this from a [StatefulWidget]'s [initState] via [addPostFrameCallback].
class OverlayHelper {
  static OverlayEntry? _entry;

  static void show(BuildContext context, List<TooltipStep> steps) {
    if (steps.isEmpty) return;
    _showStep(context, steps, 0);
  }

  static void _showStep(
      BuildContext context, List<TooltipStep> steps, int index) {
    _entry?.remove();

    if (index >= steps.length) {
      _entry = null;
      return;
    }

    final step = steps[index];
    final isLast = index == steps.length - 1;

    _entry = OverlayEntry(
      builder: (ctx) => _TooltipOverlay(
        step: step,
        stepIndex: index,
        totalSteps: steps.length,
        isLast: isLast,
        onNext: () => _showStep(context, steps, index + 1),
        onSkip: () {
          _entry?.remove();
          _entry = null;
        },
      ),
    );

    Overlay.of(context).insert(_entry!);
  }
}

// ── Internal overlay widget ────────────────────────────────────────────────

class _TooltipOverlay extends StatefulWidget {
  final TooltipStep step;
  final int stepIndex;
  final int totalSteps;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _TooltipOverlay({
    required this.step,
    required this.stepIndex,
    required this.totalSteps,
    required this.isLast,
    required this.onNext,
    required this.onSkip,
  });

  @override
  State<_TooltipOverlay> createState() => _TooltipOverlayState();
}

class _TooltipOverlayState extends State<_TooltipOverlay>
    with SingleTickerProviderStateMixin {
  Rect _targetRect = Rect.zero;
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _computeRect();
      _controller.forward();
    });
  }

  void _computeRect() {
    final box = widget.step.targetKey.currentContext?.findRenderObject()
        as RenderBox?;
    if (box == null) return;
    final offset = box.localToGlobal(Offset.zero);
    setState(() {
      _targetRect = offset & box.size;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = 8.0;
    final spotRect = _targetRect.inflate(padding);

    // Position bubble below or above the spotlight
    final bubbleTop = spotRect.bottom + 16;
    final bubbleBottom = spotRect.top - 16;
    final showBelow = bubbleTop + 160 < size.height;

    return FadeTransition(
      opacity: _fade,
      child: Stack(
        children: [
          // ── Dark scrim with spotlight hole ──
          GestureDetector(
            onTap: widget.onNext,
            child: CustomPaint(
              size: size,
              painter: _SpotlightPainter(rect: spotRect),
            ),
          ),

          // ── Tooltip bubble ──
          Positioned(
            left: 16,
            right: 16,
            top: showBelow ? bubbleTop : null,
            bottom: showBelow ? null : size.height - bubbleBottom,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress dots
                    Row(
                      children: List.generate(widget.totalSteps, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 5),
                          width: i == widget.stepIndex ? 18 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: i == widget.stepIndex
                                ? Colors.teal
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.step.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.step.description,
                      style: const TextStyle(
                          fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: widget.onSkip,
                          child: const Text('Skip',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: widget.onNext,
                          child:
                              Text(widget.isLast ? 'Done ✓' : 'Next →'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Spotlight painter ─────────────────────────────────────────────────────

class _SpotlightPainter extends CustomPainter {
  final Rect rect;
  const _SpotlightPainter({required this.rect});

  @override
  void paint(Canvas canvas, Size size) {
    final scrim = Paint()..color = Colors.black.withOpacity(0.7);

    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final holePath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(15)));

    final clipped =
        Path.combine(PathOperation.difference, fullPath, holePath);

    canvas.drawPath(clipped, scrim);

    // Glow ring around highlight
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(15)),
      Paint()
        ..color = Colors.teal.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) => old.rect != rect;
}

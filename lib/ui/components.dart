import 'package:comnote/ui/theme.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatefulWidget {
  const RecommendationCard({super.key});

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ComButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String content;
  final Icon? icon;
  final double? width, height;
  final TextStyle? textStyle;

  const ComButton({
    super.key,
    required this.onPressed,
    required this.content,
    this.icon,
    this.width,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    var tStyle =
        textStyle ??
        TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 36,
          fontFamily: 'Helvetica',
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color:
                  (Theme.of(
                            context,
                          ).extension<ComThemeExtension>()!.textShadowColor ??
                          Color(0xFF000000))
                      .withAlpha(0x4d),
            ),
          ],
        );

    List<Widget> children = [Text(content, style: tStyle)];

    if (icon != null) {
      children.add(icon!);
    }

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadows: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(0x80),
            blurRadius: 15,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: children,
          ),
        ),
      ),
    );
  }
}

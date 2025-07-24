import 'package:comnote/main.dart';
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

// TODO: Fix dropdown menu

class TopBarEntry {
  void Function(TopBarEntry) onSelected;

  String label;
  TopBarEntry({required this.label, required this.onSelected});
}

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final List<TopBarEntry> entries;

  const TopBar({super.key, required this.entries});

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(90);
}

class _TopBarState extends State<TopBar> {
  String dropdownValue = "Abcdefg";
  late TopBarEntry _currentItemSelected;

  @override
  void initState() {
    super.initState();
    _currentItemSelected = widget.entries[0];
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ext = Theme.of(context).extension<ComThemeExtension>();
    //var backgroundColor = theme.brightness == comDark.brightness ?

    return Container(
      height: widget.preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ext?.topBarGradientColors ?? [],
        ),
        border: Border(
          bottom: BorderSide(
            color: ext?.topBarBorderColor ?? theme.colorScheme.primary,
            width: 4.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ext?.topBarBorderColor?.withAlpha(127) ?? Color(0xff000000),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PopupMenuButton<TopBarEntry>(
            itemBuilder: (context) {
              return topBarEntries
                  .map((x) => PopupMenuItem(value: x, child: Text(x.label)))
                  .toList();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _currentItemSelected.label,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 20,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 4),
                        blurRadius: 8,
                        color: Color(0xFF000000).withAlpha(0x4d),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.colorScheme.onSurface,
                  size: 30.0,
                ),
              ],
            ),
            onSelected: (v) {
              setState(() {
                _currentItemSelected = v;
              });

              v.onSelected(v);
            },
          ),
        ],
      ),
    );
  }
}

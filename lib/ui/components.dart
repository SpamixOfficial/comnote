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

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
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
    ThemeData theme = Theme.of(context);
    ComThemeExtension? ext = Theme.of(context).extension<ComThemeExtension>();

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
                  .map(
                    (x) => PopupMenuItem(
                      value: x,
                      child: Text(
                        x.label,
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    ),
                  )
                  .toList();
            },
            onSelected: (v) {
              setState(() {
                _currentItemSelected = v;
              });

              v.onSelected(v);
            },
            offset: Offset(-15, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              side: BorderSide(
                color: ext?.topBarBorderColor ?? theme.colorScheme.primary,
                width: 4.0,
              ),
            ),
            shadowColor:
                ext?.topBarBorderColor?.withAlpha(127) ?? Color(0xff000000),
            color: ext?.topBarGradientColors?.last ?? Color(0xff000000),
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
          ),
        ],
      ),
    );
  }
}

enum NavItemType { settings, community, home, search, lists }

class NavItem {
  void Function(NavItemType) onSelected;

  final NavItemType type;
  final Icon icon;
  NavItem({required this.type, required this.icon, required this.onSelected});
}

// TODO: Create inline function for creating Row IconButton children with onSelected callback to run the item callback + set self as highlighted. Check figma design!

class BottomNavBar extends StatefulWidget {
  final List<NavItem> navigationItems;
  final int initialItemIndex;
  const BottomNavBar({
    super.key,
    required this.navigationItems,
    required this.initialItemIndex,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late NavItem _currentChosenItem;

  @override
  void initState() {
    super.initState();
    _currentChosenItem = widget.navigationItems[widget.initialItemIndex];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ComThemeExtension? ext = Theme.of(context).extension<ComThemeExtension>();

    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ext?.navBarGradientColors ?? [],
        ),
        border: Border(
          top: BorderSide(
            color: ext?.navBarBorderColor ?? theme.colorScheme.primary,
            width: 2.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ext?.navBarBorderColor?.withAlpha(127) ?? Color(0xff000000),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20.0,
        children: [], // TODO: HERE!!
      ),
    );
  }
}

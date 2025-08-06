import 'package:cached_network_image/cached_network_image.dart';
import 'package:comnote/main.dart';
import 'package:comnote/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecommendationCard extends StatefulWidget {
  final String title, description;
  final int? rank;
  final int popularity, id;
  final double? rating;
  final Uri poster;
  const RecommendationCard({
    super.key,
    required this.title,
    required this.description,
    required this.popularity,
    required this.poster,
    required this.rank,
    required this.rating,
    required this.id,
  });

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  @override
  Widget build(BuildContext context) {
    var truncatedTitle = widget.title.length > 26
        ? "${widget.title.substring(0, 26)}..."
        : widget.title;
    var truncatedDescription = widget.description.length > 140
        ? "${widget.description.substring(0, 140)}..."
        : widget.description;

    ThemeData theme = Theme.of(context);
    ComThemeExtension ext = Theme.of(context).extension<ComThemeExtension>()!;
    Color ratingColor;
    if (widget.rating != null) {
      double tmpRatingDouble = widget.rating!;

      ratingColor =
          (switch (tmpRatingDouble) {
            < 3.5 => ext.badRating,
            > 3.5 && < 7.49 => ext.midRating,
            _ => ext.goodRating,
          }) ??
          theme.colorScheme.onSurface;
    } else {
      ratingColor = theme.colorScheme.onSurface;
    }

    Shadow ratingTextShadow = Shadow(color: ratingColor, blurRadius: 4.0);
    BoxShadow ratingShadow = BoxShadow(
      color: ratingColor.withAlpha(0x7f),
      blurRadius: 5.0,
    );

    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: ShapeDecoration(
        color: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x82000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        spacing: 5,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Poster
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2.0),
            decoration: ShapeDecoration(
              color: theme.colorScheme.surfaceBright,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10.0),
              ),
            ),
            width: 115,
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),

              imageUrl: widget.poster.toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Info panel
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: ShapeDecoration(
                color: theme.colorScheme.surfaceBright,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10.0),
                ),
              ),
              child: Column(
                spacing: 5.0,
                children: [
                  // Text & info
                  Expanded(
                    child: Container(
                      decoration: ShapeDecoration(
                        color:
                            ext.cardBackground ?? theme.colorScheme.surfaceDim,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10.0),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        left: 4.0,
                        right: 4.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            truncatedTitle,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w700,
                              color:
                                  ext.onCardBackground ??
                                  theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                          ),
                          Divider(
                            height: 6.0, // spacing fix
                            radius: BorderRadiusGeometry.circular(30.0),
                            color:
                                ext.cardDivider ??
                                theme.colorScheme.surfaceBright,
                            thickness: 2.0,
                          ),
                          Text(
                            truncatedDescription,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.w300,
                              color:
                                  ext.onCardBackground ??
                                  theme.colorScheme.onSurface,
                            ),
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Ratings and button
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 5.0,
                      children: [
                        // Ranks
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(vertical: 1.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              buildPill(
                                context,
                                icon: Icons.emoji_events,
                                content:
                                    "#${widget.rank?.toString() ?? "????"}",
                                theme: theme,
                                ext: ext,
                              ),
                              buildPill(
                                context,
                                icon: Icons.favorite,
                                content: "#${widget.popularity.toString()}",
                                theme: theme,
                                ext: ext,
                              ),
                            ],
                          ),
                        ),
                        // Rating
                        Container(
                          width: 60,
                          decoration: ShapeDecoration(
                            color:
                                ext.cardBackground ?? theme.colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5.0),
                              side: BorderSide(color: ratingColor, width: 2),
                            ),
                            shadows: [ratingShadow],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 5.0,
                            children: [
                              Icon(
                                Icons.star,
                                size: 16.0,
                                color: ratingColor,
                                shadows: [ratingTextShadow],
                              ),
                              Text(
                                widget.rating?.toString() ?? "?.??",
                                style: TextStyle(
                                  height: 1.0, // compress so it is centered :D
                                  fontSize: 14,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  color: ratingColor,
                                  shadows: [ratingTextShadow],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Open
                        Expanded(
                          child: ComButton(
                            onPressed: () {},
                            content: "Open",
                            width: 100,
                            icon: Icon(Icons.arrow_right_alt, size: 25),
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            cornerRadius: 5.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPill(
    BuildContext context, {
    required IconData icon,
    required String content,
    required ThemeData theme,
    required ComThemeExtension ext,
  }) {
    return Container(
      width: 60,
      decoration: ShapeDecoration(
        color: ext.cardBackground ?? theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5.0),
          side: BorderSide(
            color: ext.onCardBackground ?? theme.colorScheme.onSurface,
            width: 1,
          ),
        ),
        shadows: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4.0,
            color: Colors.black.withAlpha(0x4c),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5.0,
        children: [
          Icon(
            icon,
            size: 10.0,
            color: ext.onCardBackground ?? theme.colorScheme.onSurface,
          ),
          Text(
            content,
            style: TextStyle(
              height: 1.0, // compress so it is centered :D
              fontSize: 9,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
              color: ext.onCardBackground ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class ComButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String content;
  final Icon? icon;
  final double? width, height;
  final double cornerRadius;
  final TextStyle? textStyle;

  const ComButton({
    super.key,
    required this.onPressed,
    required this.content,
    this.icon,
    this.width,
    this.height,
    this.textStyle,
    this.cornerRadius = 10.0,
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
            borderRadius: BorderRadius.circular(cornerRadius),
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

class TopBarEntry<T> {
  void Function(TopBarEntry, BuildContext) onSelected;

  T value;
  String label;
  TopBarEntry({
    required this.label,
    required this.onSelected,
    required this.value,
  });
}

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final List<TopBarEntry> entries;
  final bool homeBar;

  const TopBar({super.key, required this.entries, required this.homeBar});

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
    ComThemeExtension ext = Theme.of(context).extension<ComThemeExtension>()!;

    if (widget.homeBar) {
      return buildHomeBar(context, theme, ext);
    } else {
      return buildNormalBar(context, theme, ext);
    }
  }

  Widget buildNormalBar(
    BuildContext context,
    ThemeData theme,
    ComThemeExtension ext,
  ) {
    return Container(
      height: widget.preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ext.homeBarGradientColors ?? [],
        ),
      ),
    );
  }

  Widget buildHomeBar(
    BuildContext context,
    ThemeData theme,
    ComThemeExtension ext,
  ) {
    return Container(
      height: widget.preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ext.topBarGradientColors ?? [],
        ),
        border: Border(
          bottom: BorderSide(
            color: ext.topBarBorderColor ?? theme.colorScheme.primary,
            width: 4.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ext.topBarBorderColor?.withAlpha(127) ?? Color(0xff000000),
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

              v.onSelected(v, context);
            },
            offset: Offset(-15, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              side: BorderSide(
                color: ext.topBarBorderColor ?? theme.colorScheme.primary,
                width: 4.0,
              ),
            ),
            shadowColor:
                ext.topBarBorderColor?.withAlpha(127) ?? Color(0xff000000),
            color: ext.topBarGradientColors?.last ?? Color(0xff000000),
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
  final IconData icon;
  NavItem({required this.type, required this.icon, required this.onSelected});
}

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
  late NavItemType _currentChosenItem;

  @override
  void initState() {
    super.initState();
    _currentChosenItem = widget.navigationItems[widget.initialItemIndex].type;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var selectedColor = Theme.of(context).colorScheme.tertiary;
    ComThemeExtension? ext = Theme.of(context).extension<ComThemeExtension>();

    List<IconButton> barButtons = widget.navigationItems.map<IconButton>((x) {
      var shadows = _currentChosenItem == x.type
          ? [
              Shadow(
                color: Colors.black.withAlpha(179),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
              Shadow(
                color: selectedColor,
                blurRadius: 20.0,
                offset: Offset(0, 0),
              ),
            ]
          : [
              Shadow(
                color: Colors.black.withAlpha(179),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ];

      return IconButton(
        iconSize: 25.0,
        onPressed: () {
          setState(() {
            _currentChosenItem = x.type;
          });
          x.onSelected(x.type);
        },
        icon: Icon(x.icon, shadows: shadows, color: Colors.white),
      );
    }).toList();

    return Container(
      height: 70,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
        children: barButtons,
      ),
    );
  }
}

CustomTransitionPage fadeTransition({
  required Widget child,
  required GoRouterState state,
  required BuildContext context,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: child,
          );
        },
  );
}

import 'package:flutter/material.dart';

@immutable
class ComThemeExtension extends ThemeExtension<ComThemeExtension> {
  final Color? textShadowColor;

  final List<Color>? topBarGradientColors;
  final Color? topBarBorderColor;

  final List<Color>? navBarGradientColors;
  final Color? navBarBorderColor;

  const ComThemeExtension({
    required this.textShadowColor,
    required this.topBarGradientColors,
    required this.topBarBorderColor,
    required this.navBarGradientColors,
    required this.navBarBorderColor,
  });

  @override
  ThemeExtension<ComThemeExtension> copyWith({
    Color? textShadowColor,
    List<Color>? topBarGradientColors,
    Color? topBarBorderColor,
    List<Color>? navBarGradientColors,
    Color? navBarBorderColor,
  }) {
    return ComThemeExtension(
      textShadowColor: textShadowColor,
      topBarGradientColors: topBarGradientColors,
      topBarBorderColor: topBarBorderColor,
      navBarBorderColor: navBarBorderColor,
      navBarGradientColors: navBarGradientColors,
    );
  }

  @override
  ThemeExtension<ComThemeExtension> lerp(
    covariant ThemeExtension<ComThemeExtension>? other,
    double t,
  ) {
    if (other is! ComThemeExtension) {
      return this;
    }

    return ComThemeExtension(
      textShadowColor: Color.lerp(textShadowColor, other.textShadowColor, t),
      topBarGradientColors: other.topBarGradientColors, // lazy
      topBarBorderColor: Color.lerp(
        topBarBorderColor,
        other.topBarBorderColor,
        t,
      ),
      navBarGradientColors: other.navBarGradientColors,
      navBarBorderColor: Color.lerp(
        navBarBorderColor,
        other.navBarBorderColor,
        t,
      ),
    );
  }
}

final comLight = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff00d0ef),
    onPrimary: Color(0xff053344),
    secondary: Color(0xff9d9da8),
    onSecondary: Color(0xff09090b),
    error: Color(0xffe9003e),
    onError: Color(0xfffceeef),
    surface: Color(0xfff2f2f2),
    onSurface: Color(0xff18181b),
    surfaceDim: Color(0xffe4e4e7),
    surfaceBright: Color(0xfff8f8f8),
    tertiary: Color(0xff00D3BB)
  ),
  extensions: [
    const ComThemeExtension(
      textShadowColor: Color(0x4D000000),
      topBarGradientColors: [Color(0xfff2f2f2), Color(0xfff2f2f2)],
      topBarBorderColor: Color(0xff9D9DA8),
      navBarGradientColors: [Color(0xffF8F8F8), Color(0xff18181B)],
      navBarBorderColor: Color(0x00F8F8F8),
    ),
  ],
);

/*
@plugin "daisyui/theme" {
  name: "comdark";
  default: false;
  prefersdark: true;
  color-scheme: "dark";
  --color-base-100: oklch(12% 0.042 264.695);
  --color-base-200: oklch(20% 0.042 265.755);
  --color-base-300: oklch(27% 0.041 260.031);
  --color-base-content: oklch(96% 0.007 247.896);
  --color-primary: oklch(60% 0.118 184.704);
  --color-primary-content: oklch(98% 0.014 180.72);
  --color-secondary: oklch(59% 0.145 163.225);
  --color-secondary-content: oklch(97% 0.021 166.113);
  --color-accent: oklch(54% 0.245 262.881);
  --color-accent-content: oklch(97% 0.014 254.604);
  --color-neutral: oklch(12% 0.042 264.695);
  --color-neutral-content: oklch(98% 0.003 247.858);
  --color-info: oklch(62% 0.214 259.815);
  --color-info-content: oklch(97% 0.014 254.604);
  --color-success: oklch(72% 0.219 149.579);
  --color-success-content: oklch(98% 0.018 155.826);
  --color-warning: oklch(79% 0.184 86.047);
  --color-warning-content: oklch(98% 0.026 102.212);
  --color-error: oklch(64% 0.246 16.439);
  --color-error-content: oklch(96% 0.015 12.422);
  --radius-selector: 1rem;
  --radius-field: 0.25rem;
  --radius-box: 1rem;
  --size-selector: 0.1875rem;
  --size-field: 0.1875rem;
  --border: 1px;
  --depth: 0;
  --noise: 0;
}
*/

final comDark = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff009689),
    onPrimary: Color(0xffeffcf9),
    secondary: Color(0xff009764),
    onSecondary: Color(0xffe9faf2),
    error: Color(0xfffe1c55),
    onError: Color(0xfffceeef),
    surface: Color(0xff0d1529),
    onSurface: Color(0xffeef2f6),
    surfaceDim: Color(0xff010515),
    surfaceBright: Color(0xff1a273a),
    tertiary: Color(0xff135bf9)
  ),
  extensions: [
    const ComThemeExtension(
      textShadowColor: Color(0x4D000000),
      topBarGradientColors: [Color(0xff001878), Color(0xff010515)],
      topBarBorderColor: Color(0xff00D3BB),
      navBarGradientColors: [Color(0xff010529), Color(0xff001878)],
      navBarBorderColor: Color(0xff1a273a),
    ),
  ],
);

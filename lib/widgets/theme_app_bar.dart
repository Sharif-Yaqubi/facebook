import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

import '../provider/theme_provider.dart';

class ThemeAppBar {
  static AppBar getAppBar(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return AppBar(
      actions: [
        Row(
          children: kThemeSeedColors
              .map((e) => _buildSeedColorButton(e, context))
              .toList(),
        ),
        const SizedBox(width: 10),
        Switcher(
          value: viewmodel.brightness == Brightness.light,
          size: SwitcherSize.large,
          iconOff: Icons.dark_mode,
          iconOn: Icons.light,
          onChanged: (value) {
            if (context.mounted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                viewmodel.brightness =
                    value ? Brightness.light : Brightness.dark;
              });
            }
          },
          colorOff: viewmodel.brightness == Brightness.dark
              ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
              : Theme.of(context).colorScheme.primary,
          colorOn: viewmodel.brightness == Brightness.dark
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  static Widget _buildSeedColorButton(Color color, BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();
    return GestureDetector(
      onTap: () {
        viewmodel.seedColorIndex = kThemeSeedColors.indexOf(color);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: color,
          child: viewmodel.seedColor == color
              ? const Icon(
                  Icons.check,
                  size: 16.0,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';

class CustomCircularMenuItem extends CircularMenuItem {
  CustomCircularMenuItem(onTap, icon) : super(
    onTap: onTap,
    icon: icon,
    iconColor: Colors.white,
    iconSize: 25.0,
    boxShadow: const [],
    color: const Color(0xFF35374B),
    badgeRadius: 15.0,  );
}

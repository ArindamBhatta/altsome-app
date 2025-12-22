import 'package:flutter/material.dart';

/// Maps string icon names to Flutter IconData objects
IconData getIconData(String iconName) {
  switch (iconName) {
    // Common icons
    case 'edit':
      return Icons.edit;
    case 'pending':
      return Icons.pending;
    case 'check_circle':
      return Icons.check_circle;
    case 'calendar_today':
      return Icons.calendar_today;
    case 'construction':
      return Icons.construction;
    case 'pause':
      return Icons.pause;
    case 'inventory_2':
      return Icons.inventory_2;
    case 'approval':
      return Icons.approval;
    case 'rate_review':
      return Icons.rate_review;
    case 'local_shipping':
      return Icons.local_shipping;
    case 'cancel':
      return Icons.cancel;
    case 'archive':
      return Icons.archive;

    // Project phase icons
    case 'assignment':
      return Icons.assignment;
    case 'handyman':
      return Icons.handyman;
    case 'auto_fix_high':
      return Icons.auto_fix_high;
    case 'engineering':
      return Icons.engineering;
    case 'format_paint':
      return Icons.format_paint;
    case 'airline_seat_recline_normal':
      return Icons.airline_seat_recline_normal;
    case 'settings':
      return Icons.settings;
    case 'speed':
      return Icons.speed;
    case 'cleaning_services':
      return Icons.cleaning_services;

    // Default
    default:
      return Icons.circle;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider conditionalImageProvider(String? url, {ImageProvider? fallback}) {
  if (url != null && url.isNotEmpty) {
    if (url.startsWith('http')) {
      return NetworkImage(url);
    } else if (url.startsWith('assets/')) {
      return AssetImage(url);
    } else if (url.startsWith('file://')) {
      // Create a File object from the URI
      final file = File.fromUri(Uri.parse(url));
      return FileImage(file);
    }
  }
  return fallback ??
      const AssetImage('assets/images/default/default_avatar.png');
}

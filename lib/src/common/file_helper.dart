import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

toBytes(String path, int targetWidth, {required isLocal}) async {
  Uint8List bytes;
  if (isLocal) {
    final ByteData data = await rootBundle.load(path);
    bytes = data.buffer.asUint8List();
  } else {
    final file = await DefaultCacheManager().getSingleFile(path);
    bytes = await file.readAsBytes();
  }
  final codec = await instantiateImageCodec(bytes, targetWidth: targetWidth);
  final frameInfo = await codec.getNextFrame();
  final image = await frameInfo.image.toByteData(format: ImageByteFormat.png);

  final bitmap = BitmapDescriptor.fromBytes(image!.buffer.asUint8List());
  final icon = Completer<BitmapDescriptor>();
  icon.complete(bitmap);

  return await icon.future;
}

Future<String> uploadFile(
    io.File file, String folder, String name, int targetWidth) async {
  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref(folder).child(name);

  try {
    // It is image
    if (targetWidth > 0) {
      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(file.path);

      if (properties.width == null || properties.height == null) return '';

      int cropped = properties.width!;
      if (properties.width! > properties.height!) {
        cropped = properties.height!;
      }

      File croppedFile =
          await FlutterNativeImage.cropImage(file.path, 0, 0, cropped, cropped);

      int target = targetWidth;
      if (target > cropped) {
        target = cropped;
      }

      File compressedFile = await FlutterNativeImage.compressImage(
        croppedFile.path,
        targetWidth: target,
        targetHeight: target,
      );
      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(compressedFile);
      await uploadTask.whenComplete(() => null);
    }
    // other file type
    else {
      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(file);
      await uploadTask.whenComplete(() => null);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return '';
  }

  final String url = await storageReference.getDownloadURL();
  return '${url.split('?alt=media&token=')[0]}?alt=media';
}

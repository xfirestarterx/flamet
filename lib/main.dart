import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cas_game.dart';

void main() {
  final game = new CasGame();
  runApp(GameWidget(game: game));

  Flame.device.fullScreen();
  Flame.device.setOrientation(DeviceOrientation.portraitUp);
}

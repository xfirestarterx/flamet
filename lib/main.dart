import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  final game = new BoxGame();
  runApp(GameWidget(game: game));

  Flame.device.fullScreen();
  Flame.device.setOrientation(DeviceOrientation.portraitUp);
}

class Colors {
  static final bg = Color(0xFFFEEEEE);
  static final win = Color(0x5000AA00);
  static final lose = Color(0x50AA0000);
}

class BoxGame extends Game with TapDetector {
  late final double centerX;
  late final double centerY;
  late final Vector2 boxPos;
  final Vector2 boxSize = Vector2(150, 150);
  late final Rect box;
  final Paint boxPaint = new Paint();
  bool hasWon = false;

  @override
  Future<void> onLoad() async {
    centerX = size.x / 2;
    centerY = size.y / 2;

    boxPos = Vector2(centerX - 75, centerY - 75);

    box = Rect.fromLTWH(
      boxPos.x,
      boxPos.y,
      boxSize.x,
      boxSize.y,
    );
  }

  @override
  void update(double dt) {}

  @override
  void onTapDown(TapDownInfo event) {
    super.onTapDown(event);

    final Rect boxArea = boxPos & boxSize;
    final offset = event.eventPosition.game.toOffset();
    hasWon = boxArea.contains(offset);
  }

  @override
  void onTapUp(TapUpInfo event) {
    hasWon = false;
  }

  @override
  void onTapCancel() {
    hasWon = false;
  }

  @override
  void render(Canvas canvas) {
    boxPaint.color = hasWon ? Colors.win : Colors.lose;

    canvas.drawRect(box, boxPaint);
  }

  @override
  Color backgroundColor() => Colors.bg;
}

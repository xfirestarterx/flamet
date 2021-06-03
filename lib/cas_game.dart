import 'dart:math';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

import 'package:flamet/objects/fly.dart';

late Rect _bgRect;
Paint _bgPaint = Paint();

void _init(Vector2 size) {
  _bgRect = Rect.fromLTWH(0, 0, size.x, size.y);
  _bgPaint.color = Color(0xff576574);
}

class CasGame extends Game with TapDetector {
  late double tileSize;
  List<Fly> flies = [];
  final rnd = new Random();

  @override
  Future<void> onLoad() async {
    _init(size);
    addFly();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(_bgRect, _bgPaint);

    flies.forEach((fly) => fly.render(canvas));
    flies.removeWhere((fly) => fly.isOffScreen);
  }

  @override
  void update(double dt) {
    flies.forEach((fly) => fly.update(dt));
  }

  @override
  void onResize(Vector2 size) {
    tileSize = size.x / 9;
    super.onResize(size);
  }

  @override
  void onTapDown(TapDownInfo event) {
    final offset = event.eventPosition.game.toOffset();

    flies.forEach((fly) {
      if (fly.charRect.contains(offset)) {
        fly.onTapDown();
        addFly();
      }
    });

    super.onTapDown(event);
  }

  void addFly() {
    final pos = Vector2(
      rnd.nextDouble() * (size.x - tileSize),
      rnd.nextDouble() * (size.y - tileSize),
    );

    flies.add(new Fly(this, pos));
  }
}

import 'dart:ui';

import 'package:flame/extensions.dart';

import 'package:flamet/cas_game.dart';

class Fly {
  final _paint = Paint();
  late Rect charRect;
  late final CasGame _game;

  bool _isDead = false;
  bool isOffScreen = false;

  Fly(this._game, Vector2 pos) {
    charRect = Rect.fromLTWH(
      pos.x,
      pos.y,
      _game.tileSize,
      _game.tileSize,
    );

    _paint.color = Color(0xff6ab04c);
  }

  void render(Canvas canvas) {
    canvas.drawRect(charRect, _paint);
  }

  void update(double dt) {
    if (_isDead) {
      charRect = charRect.translate(0, _game.tileSize * 9 * dt);

      if (charRect.top > _game.size.y) {
        isOffScreen = true;
      }
    }
  }

  void onTapDown() {
    _paint.color = Color(0xffff4757);
    _isDead = true;
  }
}

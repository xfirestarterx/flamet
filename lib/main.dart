import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  final game = GameApp();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}

class GameApp extends Game with TapDetector {
  late SpriteAnimation runningRobot;
  late final robotPosition;
  final robotSize = Vector2(48, 60);

  late Sprite pressedButton;
  late Sprite unpressedButton;
  late final Vector2 buttonPosition;
  final buttonSize = Vector2(120, 30);
  bool isButtonPressed = false;

  @override
  void onTapDown(TapDownInfo event) {
    final Rect buttonArea = buttonPosition & buttonSize;
    final offset = event.eventPosition.game.toOffset();
    isButtonPressed = buttonArea.contains(offset);
  }

  @override
  void onTapUp(TapUpInfo event) {
    isButtonPressed = false;
  }

  @override
  void onTapCancel() {
    isButtonPressed = false;
  }

  @override
  Future<void> onLoad() async {
    robotPosition = Vector2(size.x / 2, size.y / 2);

    runningRobot = await loadSpriteAnimation(
      'robot.png',
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(16, 18),
        stepTime: 0.1,
      ),
    );

    buttonPosition = Vector2(size.x / 2, size.y / 2 + 80);

    unpressedButton = await loadSprite(
      'buttons.png',
      srcSize: Vector2(60, 20),
    );

    pressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
  }

  @override
  void update(double dt) {
    if (isButtonPressed) {
      runningRobot.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    runningRobot
        .getSprite()
        .render(canvas, position: robotPosition, size: robotSize);

    final button = isButtonPressed ? pressedButton : unpressedButton;

    button.render(canvas, position: buttonPosition, size: buttonSize);
  }

  @override
  Color backgroundColor() => const Color(0xFF222222);
}

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game_widget.dart';
import 'package:flame/nine_tile_box.dart';
import 'package:flame/sprite.dart';
import 'package:flame/extensions/vector2.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final size = await Flame.util.initialDimensions();

  final game = MyGame(size);
  runApp(
    GameWidget(
      game: game,
    ),
  );
}

class MyGame extends Game {
  Vector2 size;
  NineTileBox nineTileBox;

  MyGame(this.size);

  @override
  Future<void> onLoad() async {
    final sprite = Sprite(await images.load('nine-box.png'));
    nineTileBox = NineTileBox(sprite, tileSize: 8, destTileSize: 24);
  }

  @override
  void render(Canvas canvas) {
    const length = 300.0;
    final boxSize = Vector2.all(length);
    final position = (size - boxSize) / 2;
    nineTileBox.draw(canvas, position, boxSize);
  }

  @override
  void update(double t) {}
}

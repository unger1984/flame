import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../extensions/vector2.dart';
import '../sprite_animation.dart';
import 'position_component.dart';

class SpriteAnimationComponent extends PositionComponent {
  SpriteAnimation? animation;
  Paint? overridePaint;
  bool removeOnFinish = false;

  SpriteAnimationComponent(
    Vector2 size,
    SpriteAnimation this.animation, {
    this.removeOnFinish = false,
  }) {
    super.size.setFrom(size);
  }

  SpriteAnimationComponent.empty();

  SpriteAnimationComponent.sequenced(
    Vector2 size,
    Image image,
    int amount, {
    int? amountPerRow,
    Vector2? texturePosition,
    required double stepTime,
    required Vector2 textureSize,
    bool loop = true,
    this.removeOnFinish = false,
  }) {
    super.size.setFrom(size);
    animation = SpriteAnimation.sequenced(
      image,
      amount,
      amountPerRow: amountPerRow,
      texturePosition: texturePosition,
      textureSize: textureSize,
      stepTime: stepTime,
      loop: loop,
    );
  }

  SpriteAnimationComponent.variableSequenced(
    Vector2 size,
    Image image,
    int amount,
    List<double> stepTimes, {
    int? amountPerRow,
    Vector2? texturePosition,
    required Vector2 textureSize,
    bool loop = true,
  }) {
    super.size.setFrom(size);

    animation = SpriteAnimation.variableSequenced(
      image,
      amount,
      stepTimes,
      amountPerRow: amountPerRow,
      texturePosition: texturePosition,
      textureSize: textureSize,
      loop: loop,
    );
  }

  @override
  bool get shouldRemove => removeOnFinish && animation!.isLastFrame;

  @mustCallSuper
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (animation == null) {
      return;
    }
    animation!.getSprite().render(
          canvas,
          size: size,
          overridePaint: overridePaint,
        );
  }

  @override
  void update(double t) {
    super.update(t);
    if (animation == null) {
      return;
    }
    animation!.update(t);
  }
}

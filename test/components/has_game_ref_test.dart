import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/position_component.dart';
import 'package:flame/game/base_game.dart';
import 'package:test/test.dart';

class MyGame extends BaseGame {
  bool calledFoo = false;
  void foo() {
    calledFoo = true;
  }
}

class MyComponent extends PositionComponent with HasGameRef<MyGame> {
  void foo() {
    gameRef!.foo();
  }
}

void main() {
  group('has game ref test', () {
    test('simple test', () {
      final MyComponent c = MyComponent();
      final MyGame game = MyGame();
      game.add(c);
      c.foo();
      expect(game.calledFoo, true);
    });
  });
}

import 'dart:math';

extension ListRandom<T> on List<T> {
  T getRandomElement() {
    return this[Random().nextInt(length)];
  }
}
part of '../action.dart';

@Riverpod(keepAlive: true)
class BackBlockAction extends _$BackBlockAction {
  @override
  void build() {
    _controller = ref.watch(actionControllerProvider);
  }

  late AppController _controller;

  void backBlock() => _controller.backBlock();

  void unBackBlock() => _controller.unBackBlock();
}

extension BackBlockControllExt on AppController {
  void backBlock() {
    _ref.read(backBlockProvider.notifier).value = true;
  }

  void unBackBlock() {
    _ref.read(backBlockProvider.notifier).value = false;
  }
}

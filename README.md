# Flutter验证练习项目（flutterpoc）

验证练习flutter工程化开发的技能、流程和基础组件梳理。

## BLOC开发

参考：

- <https://pub.dartlang.org/packages/bloc>
- <https://pub.dartlang.org/packages/flutter_bloc>
- <https://felangel.github.io/bloc/>
- <https://github.com/felangel/bloc/tree/master/examples/>



## 1、BLOC重构Counter实现

**分支：** <https://github.com/dragonetail/flutterpoc/tree/counter_refactor>

**目标：** 根据Flutter缺省计数器例子，遵循Bloc的理念实现增减计数器的逻辑和视图分离。

**文档：** [BLOC重构Counter实现](./docs/1-counter_refactor.md)



## 2、BLOC重构Counter实现（BLOC逻辑处理工程简化）

**分支：**  <https://github.com/dragonetail/flutterpoc/tree/2-counter_refactor_simplication>>

**目标：** 根据Flutter缺省计数器例子，遵循Bloc的理念实现增减计数器的逻辑和视图分离，在第一步的基础上，抽取BaseBloc实现，简化Bloc的处理逻辑和工程化。

**文档：** [BLOC重构Counter实现和工程简化](./docs/2-counter_refactor_simplication.md)



## 3、BLOC实现APP启动页和广告页

**说明：** 本部分完成部分在分支： <https://github.com/dragonetail/flutterpoc/tree/3-splash_page>

**目标：** 涉及Flutter的Router和Splash Page工作原理，全程使用Bloc模式。

**文档：** [使用BLOC构建SplashPage的实现](./docs/3-splash_page.md)



## TODO

- 通过Dict类似模式优化Bloc中mapEventToState的if级联判断模式。
- 参考追加其他Bloc的示例
- 导入SQL工程示例（<[https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b）](https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b%EF%BC%89)



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our [online documentation](https://flutter.io/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.


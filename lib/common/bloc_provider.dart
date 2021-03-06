import 'package:flutter/material.dart';

abstract class Bloc {
  void dispose();
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;

  final Widget child;
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  })  : assert(child != null),
        assert(bloc != null),
        super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);

    return provider?.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<Bloc>> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

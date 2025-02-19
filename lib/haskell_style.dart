/// Haskell style let binding
///
/// usage:
/// ```dart
/// Widget build(BuildContext context) => let(
///   (counter: 10),
/// ).in_(
///   (b) => Text('Counter: ${b.counter}'),
/// );
/// ```
({R Function(R Function(T)) in_}) let<T extends Record, R>(T bindings) =>
    (in_: (R Function(T) f) => f(bindings));

/// Haskell style function composition
///
/// usage:
/// ```dart
/// (addOne + timesTwo)(10) // => 21
/// ```
extension ComposeExtension<TF, TG, R> on R Function(TG) {
  operator +(TG Function(TF) f) => (TF x) => this(f(x));
}

/// Haskell style where clause
/// usage:
///
/// ```dart
/// typedef _Binding = ({bool clickable});
///
/// Widget build(BuildContext context) => (_Binding b) => ElevatedButton(
///   onPressed: b.clickable ? () => print('clicked') : null,
///   child: const Text('Click me'),
/// ).where((clickable: counter < 10));
/// ```
extension FunctionExtension<R, B extends Record> on R Function(B) {
  R where(B binding) => this(binding);
}

/// Another Haskell style where clause
/// Unlike [where] extension above, this doesn't require typedef,
/// but it looks slightly different from how Haskell's where clause looks like.
///
/// ```dart
/// Widget build(BuildContext context) => where(
///   (b) => ElevatedButton(
///     onPressed: b.clickable ? () => print('clicked') : null,
///     child: const Text('Click me'),
///   ),
///   binding: (clickable: counter < 10);
/// );
/// ```
R where<T extends Record, R>(
  R Function(T) f, {
  required T binding,
}) =>
    f(binding);

/// Haskell style currying
/// Only for 2 arguments function
///
/// usage:
/// ```dart
/// final showFunc = (BuildContext context, int count) {
///   showDialog(
///     context: context,
///     builder: (context) => MyDialog(count: count),
///   );
/// }.curried;
///
/// ...
///
/// CounterWidget(
///   onCountUp: showFunc(context);
/// ),
/// ```
extension CurryExtension2<T1, T2, R> on R Function(T1, T2) {
  R Function(T2) Function(T1) get curried => (T1 x) => (T2 y) => this(x, y);
}

extension CurryExtension3<T1, T2, T3, R> on R Function(T1, T2, T3) {
  R Function(T1) Function(T2) Function(T3) get curried =>
      (T3 z) => (T2 y) => (T1 x) => this(x, y, z);
}

/// Haskell style list functions
/// [last] is not included because it's already defined in Dart.
///
/// usage:
/// ```dart
/// List<int> list = [1, 2, 3];
/// list.head // => 1
/// list.tail // => [2, 3]
/// list.init // => [1, 2]
/// list.last // => 3
/// ```
extension ListExtension<T> on List<T> {
  T get head => first;
  List<T> get tail => isEmpty ? [] : skip(1).toList();
  List<T> get init => isEmpty ? [] : take(length - 1).toList();
}

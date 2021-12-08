import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({String? name, String? descrip, bool? isDone, String? id}) = _Task;
}

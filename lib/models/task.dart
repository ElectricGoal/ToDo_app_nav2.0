import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task(
      {String? name, String? descrip, bool? isDone, String? id}) = _Task;

  // Where is factory fromJson/toJson ?
  // If the app work with API, those factories will definitely be needed.
}

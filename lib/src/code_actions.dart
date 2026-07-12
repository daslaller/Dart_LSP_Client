import 'rename.dart';

/// A single code action from `textDocument/codeAction`.
class LspCodeAction {
  LspCodeAction({
    required this.title,
    this.kind,
    this.diagnostics,
    this.isPreferred,
    this.edit,
    this.command,
  });

  final String title;
  final String? kind;
  final List<dynamic>? diagnostics;
  final bool? isPreferred;
  final LspWorkspaceEdit? edit;
  final String? command;

  factory LspCodeAction.fromJson(Map<String, dynamic> json) {
    LspWorkspaceEdit? edit;
    final rawEdit = json['edit'];
    if (rawEdit is Map<String, dynamic>) {
      edit = LspWorkspaceEdit.fromJson(rawEdit);
    }

    return LspCodeAction(
      title: json['title'] as String,
      kind: json['kind'] as String?,
      diagnostics: json['diagnostics'] as List?,
      isPreferred: json['isPreferred'] as bool?,
      edit: edit,
      command: json['command'] is Map
          ? (json['command'] as Map)['command'] as String?
          : json['command'] as String?,
    );
  }

  static List<LspCodeAction> parseResult(dynamic result) {
    if (result == null) return const [];
    if (result is! List) return const [];
    return result
        .map((item) => LspCodeAction.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

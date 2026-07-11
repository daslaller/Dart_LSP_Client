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
  final Map<String, dynamic>? edit;
  final Map<String, dynamic>? command;

  factory LspCodeAction.fromJson(Map<String, dynamic> json) {
    return LspCodeAction(
      title: json['title'] as String,
      kind: json['kind'] as String?,
      diagnostics: json['diagnostics'] as List?,
      isPreferred: json['isPreferred'] as bool?,
      edit: json['edit'] as Map<String, dynamic>?,
      command: json['command'] as Map<String, dynamic>?,
    );
  }

  static List<LspCodeAction> parseResult(dynamic result) {
    if (result is! List) return const [];
    return result
        .map((item) => LspCodeAction.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

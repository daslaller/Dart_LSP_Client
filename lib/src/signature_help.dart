class LspSignatureHelp {
  LspSignatureHelp({
    required this.signatures,
    this.activeSignature,
    this.activeParameter,
  });

  final List<LspSignatureInformation> signatures;
  final int? activeSignature;
  final int? activeParameter;

  factory LspSignatureHelp.fromJson(Map<String, dynamic> json) {
    return LspSignatureHelp(
      signatures: (json['signatures'] as List)
          .map((s) => LspSignatureInformation.fromJson(s as Map<String, dynamic>))
          .toList(),
      activeSignature: json['activeSignature'] as int?,
      activeParameter: json['activeParameter'] as int?,
    );
  }
}

class LspSignatureInformation {
  LspSignatureInformation({
    required this.label,
    this.documentation,
    this.parameters,
    this.activeParameter,
  });

  final String label;
  final String? documentation;
  final List<LspParameterInformation>? parameters;
  final int? activeParameter;

  factory LspSignatureInformation.fromJson(Map<String, dynamic> json) {
    return LspSignatureInformation(
      label: json['label'] as String,
      documentation: json['documentation'] is Map
          ? json['documentation']['value'] as String?
          : json['documentation'] as String?,
      parameters: (json['parameters'] as List?)
          ?.map((p) => LspParameterInformation.fromJson(p as Map<String, dynamic>))
          .toList(),
      activeParameter: json['activeParameter'] as int?,
    );
  }
}

class LspParameterInformation {
  LspParameterInformation({
    required this.label,
    this.documentation,
  });

  final dynamic label; // String or [int, int]
  final String? documentation;

  factory LspParameterInformation.fromJson(Map<String, dynamic> json) {
    return LspParameterInformation(
      label: json['label'],
      documentation: json['documentation'] is Map
          ? json['documentation']['value'] as String?
          : json['documentation'] as String?,
    );
  }
}

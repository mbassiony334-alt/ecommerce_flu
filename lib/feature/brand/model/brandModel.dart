class Brand {
  String name;
  String emoji;

  Brand({required this.name, required this.emoji});

  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(name: json["name"] ?? "Unknown", emoji: json["emoji"] ?? "🏷️");

  Map<String, dynamic> toJson() => {"name": name, "emoji": emoji};
}

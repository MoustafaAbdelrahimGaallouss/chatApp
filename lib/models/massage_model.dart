class MassageModel {
  final String content;
  final String id;

  MassageModel(this.id, this.content);

  factory MassageModel.fromJson(jsonData) {
    return MassageModel(
      jsonData['id'],
      jsonData['content'],
    );
  }
}

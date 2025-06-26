class MbtiAnswer {
  final int id;
  final String content;

  MbtiAnswer({required this.id, required this.content});

  factory MbtiAnswer.fromJson(Map<String, dynamic> json) {
    return MbtiAnswer(
      id: json['id'],
      content: json['content'],
    );
  }
}

class MbtiQuestion {
  final int id;
  final String content;
  final List<MbtiAnswer> answers;

  MbtiQuestion({
    required this.id,
    required this.content,
    required this.answers,
  });

  factory MbtiQuestion.fromJson(Map<String, dynamic> json) {
    return MbtiQuestion(
      id: json['id'],
      content: json['content'],
      answers:
          (json['answers'] as List).map((a) => MbtiAnswer.fromJson(a)).toList(),
    );
  }
}

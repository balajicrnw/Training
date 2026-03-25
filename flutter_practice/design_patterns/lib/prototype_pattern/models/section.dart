class Section {
  String title;
  String content;

  Section({
    required this.title,
    required this.content,
  });

  /// Deep copy clone for the section to ensure prototypes don't share references.
  Section clone() {
    return Section(
      title: title,
      content: content,
    );
  }
}

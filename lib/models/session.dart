class Session {
  final String id;
  final DateTime dateTime;
  final int maxParticipants;
  final List participants;
  Session(
      {required this.id,
      required this.dateTime,
      required this.maxParticipants,
      required this.participants});
}

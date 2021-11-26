String timeDifference(String createdAt) {
  Duration dateDifference =
      DateTime.now().difference(DateTime.parse(createdAt));
  if (dateDifference.inSeconds < 60)
    return '${dateDifference.inSeconds} seconds ago';
  if (dateDifference.inMinutes > 0 && dateDifference.inMinutes < 60)
    return '${dateDifference.inMinutes} minutes ago';
  if (dateDifference.inHours > 0 && dateDifference.inHours < 24)
    return '${dateDifference.inHours} hours ago';
  else
    return '${dateDifference.inDays} days ago';
}

class CallOnceUtil {
  Map<int, Function> runningByKey = {};
  void call(Object key, Function callback) async {
    if (!runningByKey.containsKey(key.hashCode)) {
      runningByKey[key.hashCode] = callback;
      await Future.delayed(const Duration(milliseconds: 100));
      callback();
      runningByKey.remove(key.hashCode);
    }
  }
}

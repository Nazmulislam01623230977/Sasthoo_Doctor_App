import 'dart:async';

import '../events/famillysetup_events.dart';

class FamilyRelationBloc {
  String _relation;

  // ignore: close_sinks
  final _relationStartController = StreamController<String>();
  StreamSink<String> get _inRalation => _relationStartController.sink;
  Stream<String> get ralation => _relationStartController.stream;

  // ignore: close_sinks
  final _familyEventController = StreamController<FamillyRelationEvents>();
  Sink<FamillyRelationEvents> get familyRelationSink =>
      _familyEventController.sink;

  FamilyRelationBloc() {
    _familyEventController.stream.listen(_selectedrelationshipe);
  }

  void _selectedrelationshipe(FamillyRelationEvents relations) {
    // print(ralation);
  }
}

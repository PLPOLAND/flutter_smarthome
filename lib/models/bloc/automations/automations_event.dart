part of 'automations_bloc.dart';

class AutomationsEvent extends Equatable {
  const AutomationsEvent();

  @override
  List<Object> get props => [];
}

class InitState extends AutomationsEvent {}

///Load sensors from server, and start updating them time to time
class LoadAutomations extends AutomationsEvent {}

///Load demo data
class LoadDemoAutomations extends AutomationsEvent {}

///Update list of sensors
class UpdateAutomations extends AutomationsEvent {}

///Update state of sensors
class UpdateStateOfAutomations extends AutomationsEvent {}

///Stop updating sensors
class StopUpdatingAutomations extends AutomationsEvent {}

class ErrorEvent extends AutomationsEvent {
  final String message;

  const ErrorEvent(this.message);
  ErrorEvent.exception(Exception e) : message = e.toString();

  @override
  List<Object> get props => [message];
}

class AddAutomation extends AutomationsEvent {
  final Automation automation;

  const AddAutomation(this.automation);

  @override
  List<Object> get props => [automation];
}

class RemoveAutomation extends AutomationsEvent {
  final Automation automation;

  const RemoveAutomation(this.automation);

  @override
  List<Object> get props => [automation];
}

class UpdateAutomation extends AutomationsEvent {
  final Automation automation;

  const UpdateAutomation(this.automation);

  @override
  List<Object> get props => [automation];
}

//TODO add more?
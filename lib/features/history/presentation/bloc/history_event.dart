abstract class HistoryEvent {

}

class LoadDonationsEvent extends HistoryEvent{
  final bool refresh;

  LoadDonationsEvent({this.refresh = false});
}
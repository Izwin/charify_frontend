abstract class SingleApplicationEvent{

}

class GetSingleApplicationEvent extends SingleApplicationEvent{
  final String applicationId;

  GetSingleApplicationEvent({required this.applicationId});
}
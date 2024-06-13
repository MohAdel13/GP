class ResultModel{
  late String emotion;
  late DateTime dateTime;
  late String audio;

  ResultModel({required this.emotion, required this.dateTime, required this.audio});

  ResultModel.fromJson({required Map<String, dynamic> data}){
    emotion = data['emotion'];
    dateTime = data['dateTime'].toDate();
    audio = data['audio'];
  }

  Map<String, dynamic> toJson(){
    return {
      'emotion': emotion,
      'dateTime': dateTime,
      'audio': audio
    };
  }
}
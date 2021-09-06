import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  FavoriteModel({this.id, this.job});
  final Map<String, dynamic> job;

  final String id;
  @override
  List<Object> get props => [id, job];

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(id: json['_id'], job: json['jobId']);
  }

  @override
  String toString() => 'FavoriteModel { id: $id}';
}

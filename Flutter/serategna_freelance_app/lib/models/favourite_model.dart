import 'package:equatable/equatable.dart';

class FavouriteModel extends Equatable {
  FavouriteModel({this.id, this.job});
  final Map<String, dynamic> job;
  final String id;

  @override
  List<Object> get props => [id, job];

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(id: json['id'], job: json['jobId']);
  }

  @override
  String toString() => 'FavouriteModel { id: $id}';
}

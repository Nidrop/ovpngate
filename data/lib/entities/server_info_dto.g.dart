// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerInfoDto _$ServerInfoDtoFromJson(Map<String, dynamic> json) =>
    ServerInfoDto(
      hostName: json['hostName'] as String,
      ip: json['ip'] as String,
      score: (json['score'] as num).toInt(),
      ping: (json['ping'] as num).toInt(),
      speed: (json['speed'] as num).toInt(),
      countryLong: json['countryLong'] as String,
      countryShort: json['countryShort'] as String,
      numVpnSessions: (json['numVpnSessions'] as num).toInt(),
      uptime: (json['uptime'] as num).toInt(),
      totalUsers: (json['totalUsers'] as num).toInt(),
      totalTraffic: (json['totalTraffic'] as num).toInt(),
      logType: json['logType'] as String,
      operator: json['operator'] as String,
      message: json['message'] as String,
      openVPNConfigDataBase64: json['openVPNConfigDataBase64'] as String,
    );

Map<String, dynamic> _$ServerInfoDtoToJson(ServerInfoDto instance) =>
    <String, dynamic>{
      'hostName': instance.hostName,
      'ip': instance.ip,
      'score': instance.score,
      'ping': instance.ping,
      'speed': instance.speed,
      'countryLong': instance.countryLong,
      'countryShort': instance.countryShort,
      'numVpnSessions': instance.numVpnSessions,
      'uptime': instance.uptime,
      'totalUsers': instance.totalUsers,
      'totalTraffic': instance.totalTraffic,
      'logType': instance.logType,
      'operator': instance.operator,
      'message': instance.message,
      'openVPNConfigDataBase64': instance.openVPNConfigDataBase64,
    };

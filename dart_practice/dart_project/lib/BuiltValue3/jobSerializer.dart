library job_serializer;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'jobs.dart';

part 'jobSerializer.g.dart';

@SerializersFor([
  Jobs,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
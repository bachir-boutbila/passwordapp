import 'package:hive/hive.dart';
part 'password_data.g.dart';

@HiveType(typeId: 0)
class PasswordData {
  @HiveField(0)
  final String platform;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;

  PasswordData(this.platform, this.email, this.password);
}

final _mybox = Hive.box<PasswordData>("Mybox");
List<PasswordData> passwordDataList = _mybox.values.toList();

enum AcountManagementMode { add, edit }

// make the functionality of the edit mode

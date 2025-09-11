import 'package:presensa_app/src/features/employees/data/models/shift.dart';

abstract interface class ShiftRepository {
  Future<List<Shift>> getShiftsByCompany(String companyId);

  Future<void> addShift(Shift shift, String companyId);

  Future<void> updateShift(Shift shift);
}

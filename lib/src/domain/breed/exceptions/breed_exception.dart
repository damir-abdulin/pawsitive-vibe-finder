import '../../exceptions/app_exception.dart';

/// An exception related to breed operations.
class BreedException extends AppException {
  /// Creates a [BreedException].
  const BreedException(super.message);
}

import Foundation

protocol Validatable {
  associatedtype Fields: Hashable
}

enum ValidationResult<ValidatableData: Validatable> {
  case success
  case failure(errorsForInvalidFields: [ValidatableData.Fields: String])
}


struct Validations {
  static let registration = { (registrationData: RegistrationData) -> ValidationResult<RegistrationData> in
    var errorsForInvalidFields: [RegistrationData.Fields : String] = [:]
    if registrationData.nickname.isEmpty {
      errorsForInvalidFields[.nickname] = "Никнейм не должен быть пустым!"
    }
    if registrationData.name.isEmpty {
      errorsForInvalidFields[.name] = "Имя не должно быть пустым!"
    }
    if registrationData.surname.isEmpty {
      errorsForInvalidFields[.surname] = "Фамилия не должна быть пустой!"
    }
    if registrationData.patronymic.isEmpty {
      errorsForInvalidFields[.patronymic] = "Отчество не должно быть пустым!"
    }
    if registrationData.password.count < 6 {
      errorsForInvalidFields[.password] = "Пароль должен иметь минимум 6 символов!"
    }
    
    return errorsForInvalidFields.isEmpty ? .success : .failure(errorsForInvalidFields: errorsForInvalidFields)
  }
}

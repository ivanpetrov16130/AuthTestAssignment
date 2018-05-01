import Foundation


protocol RegistrationPresenting: AnyPresenting {
  func registerUser()
  func close()
}

class RegistrationPresenter: BasicPresenter<RegistrationModule>, RegistrationPresenting {
  
  weak var view: RegistrationView?
  let provider: AuthProvider
  let validation: (RegistrationData) -> ValidationResult<RegistrationData>
  
  func inject<View>(view: View) {
    guard let view = view as? RegistrationView else { return }
    self.view = view
  }

  init(owner: RegistrationModule, provider: AuthProvider, validation: @escaping (RegistrationData) -> ValidationResult<RegistrationData>) {
    self.provider = provider
    self.validation = validation
    super.init(owner: owner)
  }
  
  func registerUser() {
    guard let registrationDataValidationResult = (view?.registrationData).flatMap(self.validation) else { return }
    switch registrationDataValidationResult {
    case .success: owner.finish(output: .finished(result: (), destination: .profile))
    case .failure(errorsForInvalidFields: let errorsForInvalidFields): view?.show(errorsForInvalidFields)
    }
  }
  
  func close() {
    owner.finish(output: .finished(result: (), destination: .previous))
  }
  
}

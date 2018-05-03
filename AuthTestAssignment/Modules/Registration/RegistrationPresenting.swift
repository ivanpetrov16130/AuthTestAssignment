import Foundation


protocol RegistrationPresenting: AnyPresenting {
  func registerUser()
  func close()
}

class RegistrationPresenter: BasicPresenter<RegistrationModule>, RegistrationPresenting {
  
  weak var view: RegistrationView?
  let provider: AuthProvider
  let userStorage: UserStorage
  let validation: (RegistrationData) -> ValidationResult<RegistrationData>
  
  func inject<View>(view: View) {
    guard let view = view as? RegistrationView else { return }
    self.view = view
  }

  init(owner: RegistrationModule, provider: AuthProvider, userStorage: UserStorage, validation: @escaping (RegistrationData) -> ValidationResult<RegistrationData>) {
    self.provider = provider
    self.userStorage = userStorage
    self.validation = validation
    super.init(owner: owner)
  }
  
  func registerUser() {
    guard let registrationData = view?.registrationData else { return }
    switch validation(registrationData) {
    case .success:
      let user = User(registrationData: registrationData)
      provider.request(.register(user: user)) { (result) in
        switch result {
        case .success(let response):
          if 200 == response.statusCode {
            self.userStorage.keep(user, for: Credentials(username: user.nickname, password: user.password))
            self.owner.finish(output: .finished(result: (), destination: .profile))
          } else {
            
          }
        case .failure(let error): self.view?.show(error: error)
        }
      }
      self.userStorage.keep(user, for: Credentials(username: user.nickname, password: user.password))
      owner.finish(output: .finished(result: (), destination: .profile))
    case .failure(errorsForInvalidFields: let errorsForInvalidFields): view?.show(errorsForInvalidFields)
    }
  }
  
  func close() {
    owner.finish(output: .finished(result: (), destination: .previous))
  }
  
}

import Foundation


class LoginPresenter: BasicPresenter<LoginModule>, LoginPresenting {
  
  let provider: AuthProvider
  let userStorage: UserStorage
  weak var view: LoginView?
  
  init(owner: LoginModule, provider: AuthProvider, userStorage: UserStorage) {
    self.provider = provider
    self.userStorage = userStorage
    super.init(owner: owner)
  }
  
  func inject(_ view: Any) {
    guard let view = view as? LoginView else { return }
    self.view = view
  }

  func login() {
    guard let username = view?.username(), let password = view?.password() else { return }
    
    let credentials = Credentials(nickname: username, password: password)
    provider.request(.login(credentials: credentials)) { (result) in
      switch result {
      case .success(let response):
        if let user = try? response.map(User.self) {
          self.userStorage.keep(user, for: credentials)
          self.owner.finish(output: .finished(result: (), destination: .profile))
        } else {
          self.view?.show(result.error)
        }
      case .failure(let error):
        self.view?.show(error)
      }
    }
  }
  
  func transitToRegistration() {
    owner.finish(output: .finished(result: (), destination: .registration))
  }
  
  func validateCredentials() {
    
  }

  
}


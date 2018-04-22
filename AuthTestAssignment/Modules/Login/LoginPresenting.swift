import Foundation


protocol LoginPresenting: AnyPresenting {
  func validateCredentials()
  func login()
  func transitToRegistration()
}


class LoginPresenter: BasicPresenter<LoginModule>, LoginPresenting {

  let provider: AuthProvider
  weak var view: LoginView?

  
  init(owner: LoginModule, provider: AuthProvider) {
    self.provider = provider
    super.init(owner: owner)
  }
  
  func inject<View>(view: View) {
    guard let view = view as? LoginView else { return }
    self.view = view
  }

  
  func login() {
    
  }
  
  
  func validateCredentials() {
    
  }
  
  func transitToRegistration() {
    
  }
  
  

  
}


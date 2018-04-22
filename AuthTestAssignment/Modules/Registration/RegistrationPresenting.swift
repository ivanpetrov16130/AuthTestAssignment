import Foundation


protocol RegistrationPresenting: AnyPresenting {

}

class RegistrationPresenter: BasicPresenter<RegistrationModule>, RegistrationPresenting {
  
  weak var view: RegistrationView?
  let provider: AuthProvider
  
  func inject<View>(view: View) {
    guard let view = view as? RegistrationView else { return }
    self.view = view
  }

  init(owner: RegistrationModule, provider: AuthProvider) {
    self.provider = provider
    super.init(owner: owner)
  }
  
}

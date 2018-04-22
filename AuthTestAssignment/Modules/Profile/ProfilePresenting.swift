import Foundation


protocol ProfilePresenting: AnyPresenting {
  
}

class ProfilePresenter: BasicPresenter<ProfileModule>, ProfilePresenting {
  
  let provider: AuthProvider

  weak var view: ProfileView?

  func inject<View>(view: View) {
    guard let view = view as? ProfileView else { return }
    self.view = view
  }
  
  init(owner: ProfileModule, provider: AuthProvider) {
    self.provider = provider
    super.init(owner: owner)
  }
  
}

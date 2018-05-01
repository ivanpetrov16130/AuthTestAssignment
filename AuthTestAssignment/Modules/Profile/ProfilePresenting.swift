import Foundation


protocol ProfilePresenting: AnyPresenting {
  
}

class ProfilePresenter: BasicPresenter<ProfileModule>, ProfilePresenting {
  
  let userStorage: UserStorage

  weak var view: ProfileView? {
    didSet {
      guard let user = userStorage.user else { return }
      view?.renderAvatar(with: user.avatarData)
      view?.greetUser(with: user.fullName)
    }
  }

  func inject<View>(view: View) {
    guard let view = view as? ProfileView else { return }
    self.view = view
  }
  
  init(owner: ProfileModule, userStorage: UserStorage) {
    self.userStorage = userStorage
    super.init(owner: owner)
  }
  
}

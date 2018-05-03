import Foundation
import AlamofireImage

protocol ProfilePresenting: AnyPresenting {
  
}

class ProfilePresenter: BasicPresenter<ProfileModule>, ProfilePresenting {
  
  let userStorage: UserStorage
  
  let imageDownloader = ImageDownloader()

  weak var view: ProfileView? {
    didSet {
      guard let user = userStorage.user else { return }
      let avatarRequest = URLRequest(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg")!)
      imageDownloader.download(avatarRequest, progress: self.view!.updateAvatarLoadingProgress, progressQueue: DispatchQueue.main) { self.view?.renderAvatar(with: $0.data) }

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

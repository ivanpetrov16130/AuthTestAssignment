import UIKit


protocol ProfileView: class {
  
}

class ProfileViewController: UIViewController {
  
  let presenter: ProfilePresenting
  
  required init(presenter: ProfilePresenting) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension ProfileViewController: ProfileView {
  
  
  
  
}

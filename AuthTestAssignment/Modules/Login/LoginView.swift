import UIKit


protocol LoginView: AnyView {
  
  func showValidationErrors()
  
  func hideValidtionErrors()
  
}

class LoginViewController: UIViewController {

  let presenter: LoginPresenting
  
  required init(presenter: LoginPresenting) {
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

extension LoginViewController: LoginView {
  
  func hideValidtionErrors() {
    
  }
  
  func showValidationErrors() {
    
  }
  

}

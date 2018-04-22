import UIKit


protocol RegistrationView: AnyView {
  
}

class RegistrationViewController: UIViewController {
  
  let presenter: RegistrationPresenting
  
  required init(presenter: RegistrationPresenting) {
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

extension RegistrationViewController: RegistrationView {
  

  
  
}

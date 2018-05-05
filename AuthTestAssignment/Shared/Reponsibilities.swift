import Foundation


protocol ErrorShowing {
  func show(error: Error)
}

extension ErrorShowing where Self: UIViewController {
  
  func show(error: Error) {
    let alertViewController = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
    alertViewController.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alertViewController, animated: true)
  }
  
}

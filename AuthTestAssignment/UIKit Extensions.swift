import UIKit


protocol NibDriven {
  
  static var nibName: String { get }
    
}

extension NibDriven {
  
  static var nibName: String { return String(describing: Self.self) }

}

extension NibDriven where Self: UIViewController  {
  

}

extension NibDriven where Self: UIView {
    
  var loadedNibContentView: UIView? {
    return Bundle(for: Self.self).loadNibNamed(type(of: self).nibName, owner: self, options: nil)?.first as? UIView
  }
  
}

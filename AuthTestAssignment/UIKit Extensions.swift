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

extension UIColor {
  
  convenience init(red: Int, green: Int, blue: Int) {
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  struct Scheme {
    static let background = UIColor(red: 21, green: 22, blue: 33)
    static let auxiliary = UIColor(red: 56, green: 25, blue: 49)
    static let accent = UIColor(red: 234, green: 46, blue: 111)
    static let tone = UIColor(red: 86, green: 30, blue: 63)
  }
  
}

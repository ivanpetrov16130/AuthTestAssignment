import UIKit


 @IBDesignable class RegistrationInputView: UIView, NibDriven {
  
  @IBOutlet private weak var textFieldTitleLabel: UILabel!
  @IBOutlet private weak var textField: UITextField!
  @IBOutlet private weak var errorHintLabel: UILabel!
  
  @IBInspectable private var title: String = "" {
    didSet { textFieldTitleLabel.text = title }
  }
  
  var inputText: String { return textField.text ?? "" }
  
  @IBInspectable private var textFieldPlaceholder: String = "" {
    didSet { textField.placeholder = textFieldPlaceholder }
  }
  
  @IBInspectable private var textFieldKeyboardType: Int = 0 {
    didSet { textField.keyboardType = UIKeyboardType(rawValue: textFieldKeyboardType) ?? .default }
  }
  
  @IBInspectable private var isTextFieldSecurityEnabled: Bool = false {
    didSet { textField.isSecureTextEntry = isTextFieldSecurityEnabled }
  }
  
  @IBInspectable var errorText: String? {
    didSet {
      if let newText = errorText {
        errorHintLabel.text = newText
        errorHintLabel.isHidden = false
      } else {
        errorHintLabel.isHidden = true
        errorHintLabel.text = ""
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadFromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadFromNib()
    
  }
  
  private func loadFromNib() {
    let nibContentView = self.loadedNibContentView
    
    nibContentView?.translatesAutoresizingMaskIntoConstraints = false
    
    nibContentView.flatMap(self.addSubview)
    
    [nibContentView?.leftAnchor.constraint(equalTo: self.leftAnchor),
     nibContentView?.rightAnchor.constraint(equalTo: self.rightAnchor),
     nibContentView?.topAnchor.constraint(equalTo: self.topAnchor),
     nibContentView?.bottomAnchor.constraint(equalTo: self.bottomAnchor)]
      .forEach{ $0?.isActive = true }
  }
  
}

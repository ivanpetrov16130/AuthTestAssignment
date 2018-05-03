import UIKit


protocol RegistrationView: class {
  var registrationData: RegistrationData { get }
  
  func show(_ errorsForInvalidFields: [RegistrationData.Fields: String]?)
  
  func show(error: Error)
}

class RegistrationViewController: UIViewController, NibDriven {  
  @IBOutlet weak var nicknameInputView: RegistrationInputView!
  @IBOutlet weak var surnameInputView: RegistrationInputView!
  @IBOutlet weak var nameInputView: RegistrationInputView!
  @IBOutlet weak var patronymicInputView: RegistrationInputView!
  @IBOutlet weak var passwordInputView: RegistrationInputView!
  @IBOutlet weak var avatarImageView: UIImageView!
  
  let presenter: RegistrationPresenting
  private lazy var imagePicker: UIImagePickerController = {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = true
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    return imagePicker
  }()
  
  required init(presenter: RegistrationPresenting) {
    self.presenter = presenter
    super.init(nibName: RegistrationViewController.nibName, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(close))
    navigationItem.title = "Регистрация"
  }
  
  @IBAction func chooseAvatar() {
    present(imagePicker, animated: true)
  }
  
  @IBAction func register(_ sender: UIButton) {
    presenter.registerUser()
  }
  
  @objc func close() {
    presenter.close()
  }
  
}


extension RegistrationViewController: RegistrationView {
  
  func show(error: Error) {
    
  }
  
  
  var registrationData: RegistrationData {
    return RegistrationData(nickname: nicknameInputView.inputText, name: nameInputView.inputText, surname: surnameInputView.inputText, patronymic: patronymicInputView.inputText, password: passwordInputView.inputText, avatarData: (avatarImageView.image).flatMap{ UIImageJPEGRepresentation($0, 1)})
  }
  
  func show(_ errorsForInvalidFields: [RegistrationData.Fields : String]?) {
    nameInputView.errorText = nil
    surnameInputView.errorText = nil
    patronymicInputView.errorText = nil
    nicknameInputView.errorText = nil
    passwordInputView.errorText = nil
    if let errorsForInvalidFields = errorsForInvalidFields {
      errorsForInvalidFields.forEach { (field, error) in
        switch field {
        case .name: nameInputView.errorText = error
        case .surname: surnameInputView.errorText = error
        case .patronymic: patronymicInputView.errorText = error
        case .nickname: nicknameInputView.errorText = error
        case .password: passwordInputView.errorText = error
        }
      }
    }
    
  }
  
}


extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    (info[UIImagePickerControllerOriginalImage] as? UIImage).flatMap {
      avatarImageView.image = $0
      avatarImageView.isHidden = false
      dismiss(animated: true)
    }
  }
}

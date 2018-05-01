import UIKit

protocol ProfileView: class {
  func renderAvatar(with data: Data?)
  func greetUser(with fullName: String)
}

class ProfileViewController: UIViewController {
  
  private let avatarImageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.contentMode = .scaleAspectFit
    imageView.isHidden = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let fullnameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let presenter: ProfilePresenting
  
  required init(presenter: ProfilePresenting) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    
    view.backgroundColor = .yellow
    
    [avatarImageView, fullnameLabel].forEach(view.addSubview)
    
    let mostTopAnchor: NSLayoutYAxisAnchor
    if #available(iOS 11.0, *) {
      mostTopAnchor = view.safeAreaLayoutGuide.topAnchor
    } else {
      mostTopAnchor = view.topAnchor
    }
    
    let mostBottomAnchor: NSLayoutYAxisAnchor
    if #available(iOS 11.0, *) {
      mostBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
    } else {
      mostBottomAnchor = view.bottomAnchor
    }
    
    [avatarImageView.topAnchor.constraint(equalTo: mostTopAnchor),
     avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
     avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
     avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
      .forEach{ $0.isActive = true }
    
    [fullnameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24),
     fullnameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
     fullnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     fullnameLabel.bottomAnchor.constraint(lessThanOrEqualTo: mostBottomAnchor, constant: 24)]
      .forEach{ $0.isActive = true }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension ProfileViewController: ProfileView {
  func greetUser(with fullName: String) {
    fullnameLabel.text = fullName
    
  }
  
  func renderAvatar(with data: Data?) {
    data.flatMap(UIImage.init(data: )).flatMap{ avatarImageView.image = $0 }
    
  }
  
  
  
  
  
}

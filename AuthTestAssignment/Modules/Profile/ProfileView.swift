import UIKit

protocol ProfileView: class, ErrorShowing {
  func renderAvatar(with data: Data?)
  func greetUser(with fullName: String)
  func updateAvatarLoadingProgress(_ progress: Progress)
}

class ProfileViewController: UIViewController {
  
  private let avatarView: AvatarView = {
    let avatarView = AvatarView(frame: .zero)
    avatarView.isHidden = true
    avatarView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    avatarView.alpha = 0.3
    return avatarView
  }()
  
  private let fullnameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 21)
    label.numberOfLines = 0
    label.textColor = UIColor.Scheme.accent
    label.shadowColor = UIColor.Scheme.tone
    label.shadowOffset = CGSize(width: 2, height: -3)
    label.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
    label.alpha = 0.3
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
    
    view.backgroundColor = UIColor.Scheme.background
    
    [avatarView, fullnameLabel].forEach(view.addSubview)
    
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
    
    [avatarView.topAnchor.constraint(equalTo: mostTopAnchor, constant: 36),
     avatarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
     avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
     avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
      .forEach{ $0.isActive = true }
    
    [fullnameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 48),
     fullnameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
     fullnameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     fullnameLabel.bottomAnchor.constraint(lessThanOrEqualTo: mostBottomAnchor, constant: 24)]
      .forEach{ $0.isActive = true }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Профиль"
    if #available(iOS 11.0, *) {
      self.navigationController?.navigationBar.prefersLargeTitles = true
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.3) {
      self.avatarView.placeholderImage = #imageLiteral(resourceName: "profilePlaceholder")
      self.avatarView.isHidden = false
      self.avatarView.transform = .identity
      self.avatarView.alpha = 1
      
      self.fullnameLabel.isHidden = false
      self.fullnameLabel.transform = .identity
      self.fullnameLabel.alpha = 1
    }
  }
  
}

extension ProfileViewController: ProfileView {
  
  func updateAvatarLoadingProgress(_ progress: Progress) {
    avatarView.loadingProgress = progress.fractionCompleted
  }
  
  func greetUser(with fullName: String) {
    fullnameLabel.text = "Добро пожаловать, \(fullName)" 
  }
  
  func renderAvatar(with data: Data?) {
    data.flatMap(UIImage.init(data: )).flatMap{ avatarView.image = $0 }
  }
  
  
  
  
  
}

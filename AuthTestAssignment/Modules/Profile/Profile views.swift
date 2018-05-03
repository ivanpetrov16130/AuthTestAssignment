import UIKit


fileprivate extension CALayer {
  
  func pulsate() {
    guard !(animationKeys() ?? []).contains("pulseAnimation") else { return }
    let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
    pulseAnimation.toValue = 1.2
    pulseAnimation.duration = 0.8
    pulseAnimation.autoreverses = true
    pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    pulseAnimation.repeatCount = .infinity
    add(pulseAnimation, forKey: "pulseAnimation")
  }
  
  func stopPulsating() {
    guard (animationKeys() ?? []).contains("pulseAnimation") else { return }
    let calmAnimation = CABasicAnimation(keyPath: "transform.scale")
    calmAnimation.fromValue = self.presentation()?.transform
    calmAnimation.toValue = 1.0
    calmAnimation.duration = 0.8
    calmAnimation.autoreverses = false
    calmAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    calmAnimation.isRemovedOnCompletion = true
    removeAnimation(forKey: "pulseAnimation")
    add(calmAnimation, forKey: "calmAnimation")
  }
  
}


class AvatarView: UIView {
  
  var loadingProgress: Double = 0 {
    didSet {
      progressLayer.strokeEnd = CGFloat(loadingProgress)
    }
  }
  
  var image: UIImage? {
    didSet {
      placeholderLayer.removeAllAnimations()
      placeholderLayer.removeFromSuperlayer()
      borderLayer.stopPulsating()
      _ = imageLayer
    }
    
  }
  
  var placeholderImage: UIImage? {
    didSet {
      _ = placeholderLayer
    }
  }
  
  private lazy var circlePath: UIBezierPath = UIBezierPath(arcCenter: .zero, radius: bounds.width / 2 + 4, startAngle: -(.pi / 2), endAngle: 3 * (.pi / 2), clockwise: true)
  
  private lazy var borderLayer: CAShapeLayer = {
    let borderLayer = CAShapeLayer()
    borderLayer.path = circlePath.cgPath
    borderLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    borderLayer.strokeColor = UIColor.Scheme.auxiliary.cgColor
    borderLayer.fillColor = borderLayer.strokeColor
    borderLayer.lineWidth = 8
    layer.addSublayer(borderLayer)
    borderLayer.pulsate()
    return borderLayer
  }()
  
  private lazy var progressLayer: CAShapeLayer = {
    let progressLayer = CAShapeLayer()
    progressLayer.path = circlePath.cgPath
    progressLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
    progressLayer.strokeColor = UIColor.Scheme.accent.cgColor
    progressLayer.lineWidth = 8
    progressLayer.lineCap = kCALineCapRound
    progressLayer.strokeEnd = 0
    progressLayer.fillColor = UIColor.Scheme.tone.cgColor
    layer.addSublayer(progressLayer)
    return progressLayer
  }()
  
  private lazy var placeholderLayer: CALayer = {
    let placeholderLayer = CALayer()
    placeholderLayer.contents = placeholderImage?.cgImage
    placeholderLayer.contentsGravity = kCAGravityResize
    placeholderLayer.frame = bounds
    placeholderLayer.cornerRadius = placeholderLayer.frame.width / 2
    placeholderLayer.masksToBounds = true
    layer.addSublayer(placeholderLayer)
    return placeholderLayer
  }()
  
  private lazy var imageLayer: CALayer = {
    let imageLayer = CALayer()
    imageLayer.contents = image?.cgImage
    imageLayer.contentsGravity = kCAGravityResize
    imageLayer.frame = bounds
    imageLayer.cornerRadius = imageLayer.frame.width / 2
    imageLayer.masksToBounds = true
    layer.addSublayer(imageLayer)
    return imageLayer
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    tintColor = UIColor.Scheme.accent
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    _ = borderLayer
    _ = progressLayer
  }
  
}

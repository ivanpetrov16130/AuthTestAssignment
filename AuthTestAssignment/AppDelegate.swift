import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var flow: ApplicationFlow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    activateThirdparties()
    
    applyCommonViewStyling()
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    flow = ApplicationFlow()
    flow?.setRootViewController(to: window)
    window.makeKeyAndVisible()
    self.window = window
    return true
  }

}

extension AppDelegate {
  
  func activateThirdparties() {
    IQKeyboardManager.shared().isEnabled = true
    IQKeyboardManager.shared().toolbarTintColor = UIColor.Scheme.accent
    IQKeyboardManager.shared().placeholderColor = UIColor.Scheme.tone
  }
  
  func applyCommonViewStyling() {
    let navigationBarAppearence = UINavigationBar.appearance()
    navigationBarAppearence.tintColor = UIColor.Scheme.background
    navigationBarAppearence.barTintColor = UIColor.Scheme.auxiliary
    navigationBarAppearence.backgroundColor = UIColor.Scheme.background
    navigationBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.Scheme.accent]
    if #available(iOS 11.0, *) {
      navigationBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.Scheme.accent]
    }
    UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.Scheme.accent], for: .normal)
    UITextField.appearance().keyboardAppearance = .dark
  }
  
}


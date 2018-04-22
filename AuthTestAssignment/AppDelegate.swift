import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var flow: ApplicationFlow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    activateThirdparties()
    
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
  }
  
}


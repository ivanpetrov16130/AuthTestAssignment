import Foundation
import Swinject


enum TransitionType {
  case modally
  case pushing
}

enum Destination {
  case profile
  case registration
  case login
  case previous
}

class ModuleRootViewStack: NSObject, UINavigationControllerDelegate {
  private var moduleRootViews: [UIViewController] = []
  
  func push<NewModule: Module>(_ module: NewModule?, transitioned: TransitionType) {
    guard let module = module, let previousModuleRootView = moduleRootViews.last else { return }
    moduleRootViews.append(module.rootView)
    module.run(basedOn: previousModuleRootView, transitioned: transitioned)
  }
  
  func set<RootModule: Module>(_ module: RootModule?, on window: UIWindow?) {
    guard let module = module, moduleRootViews.isEmpty else { return }
    let n = UINavigationController(rootViewController: module.rootView)
    moduleRootViews.append(module.rootView)
    n.delegate = self
    window?.rootViewController = n
  }
  
  func pop<CurrentModule: Module>(module: CurrentModule?) {
    guard let module = module else { return }
    _ = moduleRootViews.popLast()
    module.dismiss()
  }
  
  func replace<CurrentModule: Module, NewModule: Module>(_ currentModule: CurrentModule?, with module: NewModule?, transitioned: TransitionType) {
    self.pop(module: currentModule)
    self.push(module, transitioned: transitioned)
  }
  
}

class ApplicationFlow {
  
  typealias View = UIViewController
  
  private let moduleRootViewStack = ModuleRootViewStack()
  
  private let servicesContainer: Container = {
    let container = Container()
    container.register(AuthProvider.self) { _ in
      AuthProvider(plugins: [])
    }
    container.register(UserStorage.self) { _ in
      InMemoryUserStorage()
    }.inObjectScope(.container)
    return container
  }()
  
  private lazy var modulesContainer: Container = {
    let container = Container(parent: servicesContainer)
    container.register(LoginModule.self) { [unowned self] _ in
      LoginModule(servicesContainer: self.servicesContainer, applicationFlow: self, destinations: [.profile, .registration])
    }
    container.register(RegistrationModule.self) { [unowned self] _ in
      RegistrationModule(servicesContainer: self.servicesContainer, applicationFlow: self, destinations: [.profile, .previous])
    }
    container.register(ProfileModule.self) { [unowned self] _ in
      ProfileModule(servicesContainer: self.servicesContainer, applicationFlow: self, destinations: [.login])
    }
    return container
  }()
  
  
  func setRootViewController(to window: UIWindow?) {
    moduleRootViewStack.set(modulesContainer.resolve(LoginModule.self), on: window)
  }
  
  func finish<CurrentModule: Module>(module: CurrentModule, with output: ModuleOutput<CurrentModule.Output, CurrentModule.IntermediateData>) {
    switch module {
    case is LoginModule:
      switch output {
      case .finished(result: _, destination: let destination) where module.destinations.contains(destination):
        switch destination {
        case .profile: moduleRootViewStack.push(modulesContainer.resolve(ProfileModule.self), transitioned: .pushing)
        case .registration: moduleRootViewStack.push(modulesContainer.resolve(RegistrationModule.self), transitioned: .pushing)
        default: return
        }
      default: return
      }
    case is RegistrationModule:
      switch output {
      case .finished(result: _, destination: let destination) where module.destinations.contains(destination):
        switch destination {
        case .profile: moduleRootViewStack.push(modulesContainer.resolve(ProfileModule.self), transitioned: .pushing)
        case .previous: moduleRootViewStack.pop(module: module)
        default: return
        }
      default: return
      }
    case is ProfileModule:
      switch output {
      case .finished(_, let destination) where module.destinations.contains(destination):
        switch destination {
        case .login: moduleRootViewStack.replace(module, with: modulesContainer.resolve(LoginModule.self), transitioned: .pushing)
        default: return
        }
      default: return
      }
    default: return
    }
  }
  
  func handle<ClosedModule: Module>(unfinishedResult: ClosedModule.IntermediateData, for module: ClosedModule) {
    
  }
  
}



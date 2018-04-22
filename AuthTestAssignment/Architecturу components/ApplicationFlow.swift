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

class ApplicationFlow {
  
  typealias View = UIViewController
  
  private let servicesContainer: Container = {
    let container = Container()
    container.register(AuthProvider.self) { _ in
      AuthProvider(plugins: [])
    }
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
  
  var currentView: View?
  
  func setRootViewController(to window: UIWindow?) {
    guard let rootModule = modulesContainer.resolve(LoginModule.self) else { return }
    currentView = rootModule.rootView
    window?.rootViewController = rootModule.rootView
    
  }
  
  func finish<CurrentModule: Module>(module: CurrentModule, with output: ModuleOutput<CurrentModule.Output, CurrentModule.IntermediateData>) {
    switch module {
    case is LoginModule:
      switch output {
      case .finished(result: _, destination: let destination) where module.destinations.contains(destination):
        switch destination {
        case .profile where CurrentModule.Output.self is ProfileModule.Input.Type:
          currentView = modulesContainer.resolve(ProfileModule.self)?.runned(basedOn: module.rootView, transitioned: .pushing)
        case .registration where CurrentModule.Output.self is RegistrationModule.Input.Type:
          currentView = modulesContainer.resolve(RegistrationModule.self)?.runned(basedOn: module.rootView, transitioned: .modally)
        default: return
        }
      default: return
      }
    case is RegistrationModule:
      switch output {
      case .finished(result: _, destination: let destination) where module.destinations.contains(destination):
        switch destination {
        case .profile where CurrentModule.Output.self is ProfileModule.Input.Type:
          currentView = module.dismissed()
          currentView = currentView.flatMap { modulesContainer.resolve(ProfileModule.self)?.runned(basedOn: $0, transitioned: .pushing) }
        case .previous:
          currentView = module.dismissed()
        default: return
        }
      default: currentView = module.dismissed()
      }
    case is ProfileModule:
      switch output {
      case .finished(_, let destination) where module.destinations.contains(destination):
        switch destination {
        case .profile where CurrentModule.Output.self is LoginModule.Input.Type:
          currentView = module.dismissed()
          currentView = currentView.flatMap { modulesContainer.resolve(LoginModule.self)?.runned(basedOn: $0, transitioned: .pushing) }
        default: return
        }
      default: currentView = module.dismissed()
      }
    default: currentView = module.dismissed()
    }
  }
  
  func handle<ClosedModule: Module>(unfinishedResult: ClosedModule.IntermediateData, for module: ClosedModule) {
    
  }
  
}



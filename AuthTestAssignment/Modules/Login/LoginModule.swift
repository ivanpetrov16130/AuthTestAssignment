import Swinject

class LoginModule: Module {
  
  typealias RootView = UIViewController
  typealias Input = ()
  typealias Output = ()
  typealias IntermediateData = ()
  
  let servicesContainer: Container
  
  private(set) lazy var presentersContainer: Container = {
    let container = Container(parent: servicesContainer)
    container.register(LoginPresenting.self) { resolver in
      LoginPresenter(owner: self, provider: resolver.resolve(AuthProvider.self)!, userStorage: resolver.resolve(UserStorage.self)!)
    }
    return container
  }()
  
  private(set) lazy var viewsContainer: Container = {
    let container = Container(parent: presentersContainer)
    container.register(LoginView.self) { resolver in
      LoginViewController(presenter: resolver.resolve(LoginPresenting.self)!)
      }.initCompleted({ (resolver, loginView) in
        resolver.resolve(LoginPresenting.self)?.inject(loginView)
      })
    return container
  }()
  
  var transitioned: TransitionType?
  lazy var rootView: UIViewController = viewsContainer.resolve(LoginView.self) as! UIViewController
  
  let input: ()
  unowned let applicationFlow: ApplicationFlow
  let destinations: Set<Destination>
  
  required init(servicesContainer: Container, applicationFlow: ApplicationFlow, destinations: Set<Destination>) {
    self.servicesContainer = servicesContainer
    self.applicationFlow = applicationFlow
    self.destinations = destinations
  }
  
}



import Foundation
import Swinject


class RegistrationModule: Module {
  
  typealias RootView = UIViewController
  typealias Input = ()
  typealias Output = ()
  typealias IntermediateData = ()
  
  let servicesContainer: Container
  private(set) lazy var presentersContainer: Container = {
    let container = Container(parent: servicesContainer)
    container.register(RegistrationPresenting.self) { resolver in
      RegistrationPresenter(owner: self, provider: resolver.resolve(AuthProvider.self)!, validation: Validations.registration)
    }
    return container
  }()
  private(set) lazy var viewsContainer: Container = {
    let container = Container(parent: presentersContainer)
    container.register(RegistrationView.self) { resolver in
      RegistrationViewController(presenter: resolver.resolve(RegistrationPresenting.self)!)
      }.initCompleted({ (resolver, registrationView) in
        resolver.resolve(RegistrationPresenting.self)?.inject(view: registrationView)
      })
    return container
  }()
  
  var transitioned: TransitionType?
  lazy var rootView: UIViewController = viewsContainer.resolve(RegistrationView.self) as! UIViewController
  
  let input: ()
  unowned let applicationFlow: ApplicationFlow
  let destinations: Set<Destination>
  
  required init(servicesContainer: Container, applicationFlow: ApplicationFlow, destinations: Set<Destination>) {
    self.servicesContainer = servicesContainer
    self.applicationFlow = applicationFlow
    self.destinations = destinations
  }
  
}

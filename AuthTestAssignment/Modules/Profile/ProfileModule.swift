import Foundation
import Swinject


class ProfileModule: Module {
  
  typealias RootView = UIViewController
  typealias Input = ()
  typealias Output = ()
  typealias IntermediateData = ()
  
  let servicesContainer: Container
  
  private(set) lazy var presentersContainer: Container = {
    let container = Container(parent: servicesContainer)
    container.register(ProfilePresenting.self) { resolver in
      ProfilePresenter(owner: self, userStorage: resolver.resolve(UserStorage.self)!)
    }
    return container
  }()
  
  private(set) lazy var viewsContainer: Container = {
    let container = Container(parent: presentersContainer)
    container.register(ProfileView.self) { resolver in
      ProfileViewController(presenter: resolver.resolve(ProfilePresenting.self)!)
      }.initCompleted({ (resolver, profileView) in
        resolver.resolve(ProfilePresenting.self)?.inject(view: profileView)
      })
    return container
  }()
  
  var transitioned: TransitionType?
  lazy var rootView: UIViewController = viewsContainer.resolve(ProfileView.self) as! UIViewController
  let input: ()
  unowned let applicationFlow: ApplicationFlow
  let destinations: Set<Destination>
  
  required init(servicesContainer: Container, applicationFlow: ApplicationFlow, destinations: Set<Destination>) {
    self.servicesContainer = servicesContainer
    self.applicationFlow = applicationFlow
    self.destinations = destinations
  }
  
}

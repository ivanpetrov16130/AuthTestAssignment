import UIKit
import Swinject


protocol AnyPresenting {
  func inject<View>(view: View)
}

class BasicPresenter<OwnerModule: Module>: NSObject {

  unowned let owner: OwnerModule
  
  init(owner: OwnerModule) {
    self.owner = owner
  }
  
}


enum ModuleOutput<Result, IntermediateResult> {
  case finished(result: Result, destination: Destination)
  case cancelled(intermediateResult: IntermediateResult)
}


protocol Module: class {

  typealias PresentedView = UIViewController
  associatedtype RootView: UIViewController
  associatedtype Input
  associatedtype Output
  associatedtype IntermediateData
  
  var servicesContainer: Container { get }
  var presentersContainer: Container { get }
  var viewsContainer: Container { get }
  var applicationFlow: ApplicationFlow { get }
  var destinations: Set<Destination> { get }
  
  var rootView: RootView { get }
  
  var transitioned: TransitionType? { get set }
  
  var input: Input { get }
  
  init(servicesContainer: Container, applicationFlow: ApplicationFlow, destinations: Set<Destination>)
  
  func run<PreviosView: PresentedView>(basedOn previosView: PreviosView, transitioned: TransitionType)
  
  func finish(output: ModuleOutput<Output, Void>)
  
  func dismiss()
  
  
}

extension Module {
  
  func run<PreviosView: PresentedView>(basedOn previosView: PreviosView, transitioned: TransitionType) {
    self.transitioned = transitioned
    switch transitioned {
    case .modally: DispatchQueue.main.async { previosView.present(self.rootView, animated: true) }
    case .pushing: DispatchQueue.main.async { previosView.navigationController?.pushViewController(self.rootView, animated: true) }
    }
  }
  
  func finish(output: ModuleOutput<Output, IntermediateData>) {
    applicationFlow.finish(module: self, with: output)
  }
  
  func dismiss() {
    guard let transitioned = self.transitioned else { return }
    switch transitioned {
    case .modally: self.rootView.dismiss(animated: true)
    case .pushing: self.rootView.navigationController?.popViewController(animated: true)
    }
  }
  
}

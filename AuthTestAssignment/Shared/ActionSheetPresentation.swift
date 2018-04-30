import UIKit

protocol ActionSheetItem {
  
}

protocol ActionSheetPresenter {
  var items: [(String, () -> Void)] { get }
}

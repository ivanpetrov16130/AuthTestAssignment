import Foundation

protocol UserStorage {
  var credentials: Credentials? { get }
  var user: User? { get }
  
  func keep(_ user: User, for credentials: Credentials)
}

class InMemoryUserStorage: UserStorage {
  
  private(set) var credentials: Credentials?
  private(set) var user: User?
  
  func keep(_ user: User, for credentials: Credentials) {
    self.user = user
    self.credentials = credentials
  }
  
}

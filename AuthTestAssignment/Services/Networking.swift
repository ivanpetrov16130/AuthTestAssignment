import Foundation
import Moya


typealias AuthProvider = MoyaProvider<AuthApi>


enum AuthApi {
  case login(credentials: Credentials)
  case register(user: User)
}

extension AuthApi: TargetType {
  
  var baseURL: URL { return URL(string: "http://0.0.0.0:8080/")! }
  
  var path: String {
    switch self {
    case .login: return "/login"
    case .register: return "/register"
    }
  }
  
  var method: Moya.Method {
    return .post
  }
  
  var sampleData: Data { return Data() }
  
  var task: Task {
    switch self {
    case .login(credentials: let credentials):
      return Task.requestJSONEncodable(credentials)
    case .register(user: let user):
      return Task.requestJSONEncodable(user)
    }
  }
  
  var headers: [String : String]? { return nil }
  
}

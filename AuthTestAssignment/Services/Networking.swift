import Foundation
import Moya


typealias AuthProvider = MoyaProvider<AuthApi>


enum AuthApi {
  case login(credentials: Credentials)
  case register(user: User)
}

extension AuthApi: TargetType {
  
  var baseURL: URL { return URL(string: "https://")! }
  
  var path: String {
    switch self {
    case .login: return "/login"
    case .register: return "/register"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login: return .get
    case .register: return .post
    }
  }
  
  var sampleData: Data { return Data() }
  
  var task: Task {
    switch self {
    case .login(credentials: let credentials):
      return Task.requestParameters(parameters: ["login": credentials.login, "password": credentials.password], encoding: URLEncoding.queryString)
    case .register(user: let user):
      return Task.requestJSONEncodable(user)
    }
  }
  
  var headers: [String : String]? { return nil }
  
}

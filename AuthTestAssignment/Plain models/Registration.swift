import Foundation

struct RegistrationData: Validatable {
  
  enum Fields {
    case nickname
    case name
    case surname
    case patronymic
    case password
  }
  
  let nickname: String
  let name: String
  let surname: String
  let patronymic: String
  let password: String
  let avatarData: Data?
  
}

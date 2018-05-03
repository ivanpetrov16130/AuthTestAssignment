import Foundation

struct User: Codable {
  
  let nickname: String
  let fullName: String
  let avatarData: Data?
  let password: String
  
  init(registrationData: RegistrationData) {
    nickname = registrationData.nickname
    fullName = "\(registrationData.surname) \(registrationData.name) \(registrationData.patronymic)"
    avatarData = registrationData.avatarData
    password = registrationData.password
  }
  
}

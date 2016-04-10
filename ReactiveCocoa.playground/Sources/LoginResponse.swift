import Foundation

public struct LoginResponse {
    public let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
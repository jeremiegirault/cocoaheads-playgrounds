//: [Back to home](Intro)

//: # Designing a new System

import Foundation

protocol CacheProtocol: class {
    associatedtype Key
    associatedtype Value
    
    func get(key: Key) -> Value?
    func put(value: Value?, forKey key: Key)
    func removeAll()
}

// ----- Testing Area -----


//: [Next](@next)

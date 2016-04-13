//: [Back to home](Intro)

//: # WTF Swift Moments

import Foundation

func test() {
    
    let computedOnce: Bool = {
        print("once")
        return true
    }()
    
    var computedTwice: Bool {
        print("twice")
        return true
    }
    
    if computedOnce {
    }
    if computedOnce {
    }
    
    if computedTwice {
    }
    if computedTwice {
    }
}

test()

//: [Next](@next)

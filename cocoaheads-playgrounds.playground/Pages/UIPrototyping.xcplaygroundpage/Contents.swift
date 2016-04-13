//: [Back to home](Intro)

//: # Prototyping UI

import UIKit
import XCPlayground

struct CircleButtonListViewItem {
    let title: String
    let image: UIImage?
    let color: UIColor
}

let image = [#Image(imageLiteral: "Icon100.png")#]

class CircleButtonListView: UIView {
    let items: [CircleButtonListViewItem]
    let maxItemCount = 4
    
    init(items: [CircleButtonListViewItem]) {
        self.items = items
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 100))
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.items = []
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
    }
}

//: [Next](@next)

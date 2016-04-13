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
        putItems(self.items)
    }
    
    override func layoutSubviews() {
        subviews.enumerate().forEach { index, view in
            view.center = CGPoint(x: computeX(index, viewCount: subviews.count), y: center.y)
        }
    }
    
    private func computeX(viewIndex: Int, viewCount: Int) -> CGFloat {
        return CGFloat(viewIndex+1) * bounds.width / CGFloat(viewCount+1)
    }
    
    private func putItems(items: [CircleButtonListViewItem], animatedFromIndex: Int? = nil) {
        subviews.forEach { $0.removeFromSuperview() }
        
        items
            .prefix(maxItemCount)
            .enumerate()
            .forEach { index, item in
                addItem(item, atIndex: index)
            }
        
        if let animatedFromIndex = animatedFromIndex {
            let x = computeX(animatedFromIndex, viewCount: min(maxItemCount, items.count))
            
            subviews.forEach { view in
                view.center = CGPoint(x: x, y: center.y)
                view.alpha = 0.0
            }
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: [], animations: {
                self.subviews.forEach { $0.alpha = 1.0 }
                self.setNeedsLayout()
                self.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    private func addItem(item: CircleButtonListViewItem, atIndex index: Int) {
        let rv = UIButton(type: .Custom)
        
        let size: CGFloat = 50
        rv.addTarget(self, action: #selector(CircleButtonListView.buttonTouched(_:)), forControlEvents: .TouchUpInside)
        rv.tag = index
        rv.setImage(item.image, forState: .Normal)
        rv.backgroundColor = item.color
        rv.layer.cornerRadius = size*0.5
        rv.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        
        addSubview(rv)
    }
    
    func buttonTouched(button: UIButton) {
        putItems(self.items, animatedFromIndex: button.tag)
    }
}

XCPlaygroundPage.currentPage.liveView = CircleButtonListView(items: [
    CircleButtonListViewItem(title: "test", image: image, color: .orangeColor()),
    CircleButtonListViewItem(title: "test", image: image, color: .yellowColor()),
    CircleButtonListViewItem(title: "test", image: image, color: .purpleColor()),
    CircleButtonListViewItem(title: "test", image: image, color: .blueColor())
    ])

//: [Next](@next)

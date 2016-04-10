//: [Back to home](Intro)

import UIKit
import XCPlayground

let image = [#Image(imageLiteral: "Icon.png")#]
let meme = [#Image(imageLiteral: "hurah.jpg")#]

enum Direction {
    case Forward
    case Backward
}

class MyController: UIViewController {
    
    private lazy var icon: UIImageView = UIImageView(image: meme)
    private lazy var restartAnim: UIButton = UIButton(type: .System)
    private var direction: Direction = .Forward
    
    override func viewDidLoad() {
        view.backgroundColor = .whiteColor()
        
        [icon, restartAnim].forEach(view.addSubview)
        
        restartAnim.setTitle("restart", forState: .Normal)
        restartAnim.addTarget(self, action: #selector(changeDirection), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        icon.frame = CGRect(x: 10, y: 10, width: 64, height: 64)
        
        restartAnim.sizeToFit()
        restartAnim.frame.origin.y = 10
        restartAnim.center.x = view.center.x
    }
    
    @objc func changeDirection() {
        direction = (direction == .Forward) ? .Backward : .Forward
        restartAnimation()
    }
}

extension MyController {
    func restartAnimation() {
        icon.layer.removeAllAnimations()
        
        let pathAnim = CAKeyframeAnimation(keyPath: "position")
        pathAnim.calculationMode = kCAAnimationPaced
        pathAnim.removedOnCompletion = false
        pathAnim.fillMode = kCAFillModeForwards
        pathAnim.repeatCount = Float.infinity
        pathAnim.rotationMode = "auto"
        pathAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnim.duration = 25.0;
        
        // Create a circle path
        let path = CGPathCreateWithRoundedRect(view.bounds.insetBy(dx: 100, dy: 100), 25, 25, nil)
        if direction == .Forward {
            pathAnim.path = path
        } else {
            let reversed = UIBezierPath(CGPath: path).bezierPathByReversingPath().CGPath
            pathAnim.path = reversed
        }
        
        icon.layer.addAnimation(pathAnim, forKey: "movingAnim")
    }
}

// start live preview

XCPlaygroundPage.currentPage.liveView = MyController()

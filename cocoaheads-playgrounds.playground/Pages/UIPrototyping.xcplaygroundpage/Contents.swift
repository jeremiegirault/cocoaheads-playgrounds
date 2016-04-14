//: [Back to home](Intro)

//: # Prototyping UI

import UIKit
import XCPlayground

class MyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        backgroundColor = [#Color(colorLiteralRed: 0.1898319721, green: 0.3972307742, blue: 0.8150287867, alpha: 1)#]
        
        let waveLayer = CAGradientLayer()
        
        let gradColor = [#Color(colorLiteralRed: 0.4859457612, green: 0.6706994176, blue: 0.9988729954, alpha: 1)#] //UIColor(white: 1.0, alpha: 0.5) //
        let border = gradColor.colorWithAlphaComponent(0.0)
        waveLayer.colors = [ border, gradColor, gradColor, border ].map { $0.CGColor }
        waveLayer.locations = [0, 0.0, 1, 1 ]
        waveLayer.startPoint = CGPoint(x: 0, y: 0.5)
        waveLayer.endPoint = CGPoint(x: 1, y: 0.5)
        waveLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        let anim = CABasicAnimation(keyPath: "transform.translation.x")
        anim.repeatCount = Float.infinity
        anim.fromValue = -32
        //anim.autoreverses = true
        anim.toValue = 300
        anim.duration = 2
        waveLayer.addAnimation(anim, forKey: "waving")
        layer.addSublayer(waveLayer)
    }
}

XCPlaygroundPage.currentPage.liveView = MyView(frame: CGRect(x: 0, y: 0, width: 300, height: 2))

//: [Next](@next)

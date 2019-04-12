//
//  CircularFillAnimation.swift
//  eStore
//
//  Created by Vladislav Kondrashkov on 4/12/19.
//  Copyright © 2019 Vladislav Kondrashkov. All rights reserved.
//

import UIKit

class CircularFillAnimation: NSObject {
    private unowned var view: UIView
    private let position: CGPoint
    private let contextType: AnimationContextType

    private let maskLayer = CAShapeLayer()
    private var snapshot: UIView!

    private var completion: (() -> Void)?

    init(view: UIView,
         position: CGPoint,
         contextType: AnimationContextType) {

        self.view = view
        self.position = position
        self.contextType = contextType
        super.init()
    }
}

// MARK: - CAAnimationDelegate implementation
extension CircularFillAnimation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.snapshot.removeFromSuperview()
        completion?()
    }
}

// MARK: - Animation implementation
extension CircularFillAnimation: Animation {
    func run(completion: (() -> Void)?) {
        self.completion = completion
        let maxSideSize = max(snapshot.bounds.width, snapshot.bounds.height)

        let path = UIBezierPath(rect: snapshot.bounds)
        path.addArc(withCenter: position, radius: maxSideSize, startAngle: 0.0, endAngle: CGFloat(2 * Double.pi), clockwise: true)

        let scale = CABasicAnimation(keyPath: "path")
        scale.toValue = path.cgPath
        scale.duration = 0.25
        scale.timingFunction = CAMediaTimingFunction(name: .easeIn)
        scale.isRemovedOnCompletion = false
        scale.delegate = self
        scale.fillMode = .forwards
        maskLayer.add(scale, forKey: scale.keyPath)
    }

    func prepare() {
        snapshot = contextType == .window
            ? UIScreen.main.snapshotView(afterScreenUpdates: false)
            : view.snapshotView(afterScreenUpdates: true)

        let path = UIBezierPath(rect: snapshot.bounds)
        path.addArc(withCenter: position, radius: 5, startAngle: 0.0, endAngle: CGFloat(2 * Double.pi), clockwise: true)

        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd

        snapshot.layer.mask = maskLayer
        snapshot.clipsToBounds = true

        contextType == .window
            ? view.window?.addSubview(snapshot)
            : view.addSubview(snapshot)
    }
}

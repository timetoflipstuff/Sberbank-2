//
//  WelcomeViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Добро\nпожаловать!"
        label.font = .boldSystemFont(ofSize: 44)
        return label
    }()
    
    let startButton = UIButton(title: "Начать", fontSize: 30, cornerRadius: 24)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        welcomeLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        startButton.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
    }
    
    
    @objc private func handleStart() {
        if AppDelegate.defaults.value(forKey: "token") != nil {
            performAnimation()
        } else {
            AppDelegate.shared.rootViewController.switchToLogout()
        }
    }
    
    private func performAnimation() {
        
        
        welcomeLabel.removeFromSuperview()
        startButton.removeFromSuperview()

        let trackLayer = CAShapeLayer()
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 180, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 3
        basicAnimation.delegate = self
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        self.shapeLayer.add(basicAnimation, forKey: "key")
    }

}

extension WelcomeViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
}

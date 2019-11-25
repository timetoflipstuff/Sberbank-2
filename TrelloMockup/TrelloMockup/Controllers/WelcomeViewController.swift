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
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = 0.7
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandAnimation.duration = 1
        expandAnimation.fromValue = 1
        expandAnimation.toValue = 1.15
        expandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        expandAnimation.autoreverses = true
        expandAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        startButton.layer.add(pulseAnimation, forKey: nil)
        startButton.layer.add(expandAnimation, forKey: nil)
    }
            
    @objc private func handleStart() {
        if AppDelegate.defaults.value(forKey: "token") != nil {
//            AppDelegate.shared.rootViewController.switchToMainScreen()
            performAnimation()
        } else {
            AppDelegate.shared.rootViewController.switchToLogout()
        }
    }
    
    private func performAnimation() {
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.duration = 0.3
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        fadeAnimation.isRemovedOnCompletion = true
        
        let expandAnimation = CABasicAnimation(keyPath: "transform.scale")
        expandAnimation.duration = 0.3
        expandAnimation.fromValue = 1
        expandAnimation.toValue = 3
        expandAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        expandAnimation.delegate = self
        expandAnimation.isRemovedOnCompletion = true
        
        welcomeLabel.layer.add(fadeAnimation, forKey: nil)
        startButton.layer.add(fadeAnimation, forKey: nil)
        startButton.layer.add(expandAnimation, forKey: nil)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.startButton.removeFromSuperview()
            self.welcomeLabel.removeFromSuperview()
        }
        
    }
    
}
        
extension WelcomeViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
}



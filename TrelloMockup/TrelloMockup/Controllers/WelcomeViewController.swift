//
//  WelcomeViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!
    
    
    var orangeSquare: UIView!

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
        
        orangeSquare = UIView(frame: CGRect(x: self.view.frame.width / 2 - 200, y: 0, width: 400, height: 400))
        orangeSquare.layer.cornerRadius = 200
        
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
        
        UIView.animate(withDuration: 5, animations: {
            self.welcomeLabel.removeFromSuperview()
            self.startButton.removeFromSuperview()
            
            self.orangeSquare.backgroundColor = .orange
            self.view.addSubview(self.orangeSquare)
            
            self.animator = UIDynamicAnimator(referenceView: self.view)
            let gravity = UIGravityBehavior(items: [self.orangeSquare])
            self.animator.addBehavior(gravity)
            
            self.collision = UICollisionBehavior(items: [self.orangeSquare])
            self.collision.translatesReferenceBoundsIntoBoundary = true
            self.animator.addBehavior(self.collision)
            
            let elasticity = UIDynamicItemBehavior(items: [self.orangeSquare])
            elasticity.elasticity = 0.7
            self.animator.addBehavior(elasticity)
        }) { (finished) in
            AppDelegate.shared.rootViewController.switchToMainScreen()
        }
        
        
        
    }

}

//extension WelcomeViewController: CAAnimationDelegate {
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        AppDelegate.shared.rootViewController.switchToMainScreen()
//    }
//}

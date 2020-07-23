//
//  UIViewExtension.swift
//  Eventos
//
//  Created by Douglas Hennrich on 21/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit
import Lottie

extension UIView {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func loadFromNibNamed(_ nibNamed: String, _ bundle: Bundle? = Bundle.main) -> UINib {
        return UINib(nibName: nibNamed, bundle: bundle)
    }

    class func loadNib(_ bundle: Bundle? = Bundle.main) -> UINib {
        return loadFromNibNamed(self.identifier, bundle)
    }
 
    func startLoader(withProgress: Bool? = nil, message: String? = nil) {
        let viewLoading = UIView(frame: UIApplication.shared.windows.first?.frame ?? .zero)
        viewLoading.tag = 99999
        viewLoading.backgroundColor = .black
        viewLoading.alpha = 0.7
        viewLoading.center = self.center
        
        let animationView = AnimationView(name: "loading", bundle: .main)
        animationView.frame = CGRect(x: viewLoading.center.x - 55,
                                     y: viewLoading.center.y - 50,
                                     width: 100,
                                     height: 100)
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        viewLoading.addSubview(animationView)
        
        animationView.play()
        
        if withProgress != nil {
            let progressBarSize = CGFloat(200)
            let distanceToBottom = CGFloat(100)
            
            viewLoading.alpha = 0.7
            
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.tag = 99998
            progressView.frame = CGRect(
                x: viewLoading.center.x - progressBarSize/2,
                y: viewLoading.frame.height - distanceToBottom,
                width: progressBarSize,
                height: 20
            )
            progressView.setProgress(0.0, animated: true)
            progressView.trackTintColor = .lightGray
            progressView.tintColor = .white
            viewLoading.addSubview(progressView)
        }
        
        if message != nil {
            let messageSize = CGFloat(300)
            viewLoading.alpha = 0.7
            
            let messageLabel = UILabel()
            messageLabel.frame = CGRect(
                x: viewLoading.center.x - messageSize/2,
                y: viewLoading.frame.height / 2 + 60,
                width: viewLoading.frame.width * 0.8,
                height: 50
            )
            messageLabel.font = .systemFont(ofSize: 20, weight: .bold)
            messageLabel.textColor = .white
            messageLabel.text = message
            messageLabel.textAlignment = .center
            viewLoading.addSubview(messageLabel)
        }
        
        self.addSubview(viewLoading)
        self.bringSubviewToFront(viewLoading)
    }
    
    func stopLoader() {
        self.subviews.forEach { view in
            if view.tag == 99999 {
                view.removeFromSuperview()
            }
        }
    }
    
    func cornerRounded(with radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func cornerRounded() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}

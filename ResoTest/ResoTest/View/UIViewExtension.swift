//
//  UIViewExtension.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 13.07.2022.
//

import UIKit

extension UIView {
 
 // MARK: Anchors
    
 func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
     
     var topInset    = CGFloat(0)
     var bottomInset = CGFloat(0)
     
     if #available(iOS 11, *), enableInsets {
         let insets = self.safeAreaInsets
         topInset = insets.top
         bottomInset = insets.bottom
         print("Top: \(topInset)")
         print("bottom: \(bottomInset)")
     }
     
     translatesAutoresizingMaskIntoConstraints = false
     
     if let top = top {
         self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
     }
     if let left = left {
         self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
     }
     if let right = right {
         rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
     }
     if let bottom = bottom {
         bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
     }
     if height != 0 {
         heightAnchor.constraint(equalToConstant: height).isActive = true
     }
     if width != 0 {
         widthAnchor.constraint(equalToConstant: width).isActive = true
     }
 
 }
    
 // MARK: Shadows
    
 func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = .zero
    layer.shadowRadius = 10
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
 }

 func addShadow(to edges: [UIRectEdge], radius: CGFloat = 10.0, opacity: Float = 0.3, color: CGColor = UIColor.black.cgColor) {

        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.bounds
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity

            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }

 func removeAllShadows() {
    if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
    }
 }
   
}


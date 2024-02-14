//
//  CompoundView.swift
//  compound
//
//  Created by Daniel Jones on 2/13/24.
//

import UIKit

class CompoundView: UIView {
    var containerView: UIView!
    var assetViews: [ExpandableView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorHelper.color(fromHex: "#070F18")
        setContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerView() {
        containerView = UIView()
        self.containerView.backgroundColor = ColorHelper.color(fromHex: "#1D2833")
        self.layer.borderWidth = 0.25
        self.layer.borderColor = ColorHelper.color(fromHex: "#F9FAFB26").cgColor
        
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60)
        ])
    }
    
    func add(_ assets: [Asset]) {
        for (index, asset) in assets.enumerated() {
            let expandableView = ExpandableView()
            expandableView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(expandableView)
            expandableView.backgroundColor = .red
            assetViews.append(expandableView)
            
            var topAnchor = expandableView.topAnchor.constraint(equalTo: containerView.topAnchor)
            if index > 0 {
                let aboveView = assetViews[index - 1]
                topAnchor = expandableView.topAnchor.constraint(equalTo: aboveView.bottomAnchor)
            }
            
            NSLayoutConstraint.activate([
                expandableView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
                expandableView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
                topAnchor,
                expandableView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
    
    
}

class ExpandableView: UIView {
    var isExpanded = false
    var heightConstraint: NSLayoutConstraint?
    let logoImg = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initial height constraint
        heightConstraint?.isActive = true
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        makeViewTappable()
        setLogoImg()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setLogoImg() {
        self.addSubview(logoImg)
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoImg.widthAnchor.constraint(equalToConstant: 40),
            logoImg.heightAnchor.constraint(equalToConstant: 40),
            logoImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
        ])
    }
    
    func makeViewTappable() {
        // Make sure the view can interact with the user
        self.isUserInteractionEnabled = true
        
        // Initialize the tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpandCollapse))
        self.addGestureRecognizer(tapGesture)
    }
        
    @objc func toggleExpandCollapse() {
        isExpanded.toggle()
        heightConstraint?.constant = isExpanded ? 200 : 50 // Expanded and collapsed heights
        
        UIView.animate(withDuration: 0.3) {
            self.superview?.layoutIfNeeded() // Animates the height change
        }
    }
}

//
//self.addSubview(containerView)
//containerView.translatesAutoresizingMaskIntoConstraints = false
//containerView.heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 100)
//NSLayoutConstraint.activate([
//    containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//    containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//    containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
//    containerView.heightConstraint!
//])

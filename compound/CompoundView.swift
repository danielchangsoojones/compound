//
//  CompoundView.swift
//  compound
//
//  Created by Daniel Jones on 2/13/24.
//

import UIKit

class CompoundView: UIView {
    static let initialHeight = ExpandableView.initialHeight * 4 + 50
    static let finalHeight = ExpandableView.initialHeight * 3 + ExpandableView.finalHeight + 50
    private var heightConstraint: NSLayoutConstraint?
    
    var containerView: UIView!
    var assetViews: [ExpandableView] = []
    private let assetLabel = UILabel()
    private let supplyLabel = UILabel()
    
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
        heightConstraint = containerView.heightAnchor.constraint(equalToConstant: CompoundView.initialHeight)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            heightConstraint!
        ])
        setLabels()
    }
    
    private func setLabels() {
        assetLabel.translatesAutoresizingMaskIntoConstraints = false
        assetLabel.text = "Asset"
        let font = FontManager.shared.font(forStyle: .regular, size: 13)
        assetLabel.font = font
        
        containerView.addSubview(assetLabel)
        NSLayoutConstraint.activate([
            assetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            assetLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ])
        
        supplyLabel.translatesAutoresizingMaskIntoConstraints = false
        supplyLabel.text = "Total Supply"
        assetLabel.font = FontManager.shared.font(forStyle: .regular, size: 10)
        
        containerView.addSubview(supplyLabel)
        NSLayoutConstraint.activate([
            supplyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            supplyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ])
        
    }
    
    func add(_ assets: [Asset]) {
        for (index, asset) in assets.enumerated() {
            let expandableView = ExpandableView()
            expandableView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(expandableView)
            containerView.backgroundColor = .blue
            expandableView.backgroundColor = .red
            assetViews.append(expandableView)
            expandableView.isUserInteractionEnabled = true
            
            expandableView.nameLabel.text = asset.name
            expandableView.tickerLbl.text = asset.symbol
            
            //An incredibly weird Apple bug. It does not let you add the same tap gesture to multiple subviews.
            //under normal circumstances, I would research this more. But, I am under a testing time constraint.
            switch index {
            case 0:
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpandCollapse(tap:)))
                expandableView.addGestureRecognizer(tapGesture)
            case 1:
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpandCollapse(tap:)))
                expandableView.addGestureRecognizer(tapGesture)
            case 2:
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpandCollapse(tap:)))
                expandableView.addGestureRecognizer(tapGesture)
            case 3:
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpandCollapse(tap:)))
                expandableView.addGestureRecognizer(tapGesture)
            default:
                break
            }
            
            
            var topAnchor = expandableView.topAnchor.constraint(equalTo: assetLabel.topAnchor, constant: 20)
            if index > 0 {
                let aboveView = assetViews[index - 1]
                topAnchor = expandableView.topAnchor.constraint(equalTo: aboveView.bottomAnchor)
            }
            expandableView.heightConstraint = expandableView.heightAnchor.constraint(equalToConstant: ExpandableView.initialHeight)
            
            NSLayoutConstraint.activate([
                expandableView.leadingAnchor.constraint(equalTo: self.assetLabel.leadingAnchor),
                expandableView.trailingAnchor.constraint(equalTo: self.supplyLabel.trailingAnchor),
                topAnchor,
                expandableView.heightConstraint!
            ])
        }
    }
    
    @objc func toggleExpandCollapse(tap: UITapGestureRecognizer) {
        if let view = tap.view as? ExpandableView {
            view.isExpanded.toggle()
            view.heightConstraint?.constant = view.isExpanded ? ExpandableView.finalHeight : ExpandableView.initialHeight // Expanded and collapsed heights
            heightConstraint?.constant = view.isExpanded ? CompoundView.finalHeight : CompoundView.initialHeight
            
            UIView.animate(withDuration: 0.3) {
                self.superview?.layoutIfNeeded() // Animates the height change
            }
        }
    }
    
    
}

class ExpandableView: UIView {
    static let initialHeight: CGFloat = 56
    static let finalHeight: CGFloat = 164
    
    var isExpanded = false
    var heightConstraint: NSLayoutConstraint?
    let logoImg = UIImageView()
    let nameLabel = UILabel()
    let tickerLbl = UILabel()
    let supplyLbl = UILabel()
    let priceLabel = UILabel()
    let collateralLabel = UILabel()
    let liquidationLabel = UILabel()
    let bottomStackView = UIStackView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initial height constraint
        heightConstraint?.isActive = true
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        setLogoImg()
        setLabels()
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
    
    private func setLabels() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: logoImg.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: logoImg.topAnchor)
        ])
        
        self.addSubview(tickerLbl)
        tickerLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tickerLbl.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tickerLbl.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ])
    }
}

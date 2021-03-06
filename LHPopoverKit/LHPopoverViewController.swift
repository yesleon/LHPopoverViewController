//
//  LHPopoverViewController.swift
//  LHPopoverKit
//
//  Created by 許立衡 on 2018/10/30.
//  Copyright © 2018 narrativesaw. All rights reserved.
//

open class LHPopoverViewController: UIViewController {
    
    public static var backgroundColor: UIColor?
    
    private lazy var containedView = UIStackView(arrangedSubviews: [])
    
    open var axis: NSLayoutConstraint.Axis {
        get {
            return containedView.axis
        }
        set {
            containedView.axis = newValue
        }
    }
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
    open override func loadView() {
        containedView.axis = .vertical
        view = containedView
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredContentSize = containedView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if preferredContentSize != containedView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) {
            preferredContentSize = containedView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resignFirstResponder()
    }

    public init(popoverSource: LHPopoverSource, permittedArrowDirections: UIPopoverArrowDirection = .any) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .popover
        if let popoverController = popoverPresentationController {
            popoverController.delegate = self
            popoverController.setPopoverSource(popoverSource)
            popoverController.backgroundColor = LHPopoverViewController.backgroundColor
            popoverController.permittedArrowDirections = permittedArrowDirections
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addManagedView(_ managedView: UIView) {
        containedView.addArrangedSubview(managedView)
    }
    
}

extension LHPopoverViewController: UIPopoverPresentationControllerDelegate {
    
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
}

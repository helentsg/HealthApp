//
//  ViewController.swift
//  HealthApp
//
//  Created by Elena Tsegelnik on 25.06.2020.
//  Copyright © 2020 Elena Tsegelnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView     : UIView!
    @IBOutlet weak var label             : UILabel!
    @IBOutlet weak var plusButton        : UIButton!
    @IBOutlet weak var minusButton       : UIButton!
    var circleGraphView                  : CircleGraphView!
    let hundred                          : Int = 100
    var grathValue                       : Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        updateLabelAndGrath()
        setupCircleGrathView()
        
    }
    
    func setupView() {
        
        let containerFrame = containerView.frame
        circleGraphView = CircleGraphView(frame: containerFrame)
        
    }
    
    func updateLabelAndGrath() {
        label.text = "\(grathValue) / \(hundred)"
        var ratio = CGFloat(Double(grathValue) / Double(hundred))
        ratio = ratio == 0 ? 0.0001 : ratio
        circleGraphView.animate(for: ratio)
    }
    
    func setupCircleGrathView() {
        
        containerView.addSubview(circleGraphView)
        circleGraphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleGraphView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            circleGraphView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            circleGraphView.topAnchor.constraint(equalTo: containerView.topAnchor),
            circleGraphView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        
        grathValue += 10
        updateLabelAndGrath()
        
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        
        grathValue = (grathValue > 0 ) ? (grathValue - 10) : 0
        updateLabelAndGrath()
        
    }
    
    
}


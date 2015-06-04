//
//  ViewController.swift
//  SlotMachine
//
//  Created by Gemma Shearer on 04/06/2015.
//  Copyright (c) 2015 GemmaShearer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //these are being unwrapped because they are already there
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    //this is creating a UIView in code rather than in the storyboard. These constants are global
    //lowercase k means a constant - recognise as a constant
    let kMarginForView:CGFloat = 10.0 //gives a 10 point margin
    let KSixth:CGFloat = 1.0/6.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpContainerViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpContainerViews() {
        
        // what does all this mean?
        
        //this is setting up a frame so it is all relative to the superview relative to the superviews bounds
        self.firstContainer = UIView(frame: CGRect (x: self.view.bounds.origin.x + kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * KSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        
        // function to add the firstContainer subview to the current view
        self.view.addSubview(self.firstContainer)
        
        //code for the rest of the containers -  same as the others but slightly different positions

        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * KSixth)))
        
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * KSixth))

        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * KSixth))
        
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
        
        
}
}

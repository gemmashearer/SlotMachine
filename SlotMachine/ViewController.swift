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
    
    var titleLabel: UILabel!
    
    //this is creating a UIView in code rather than in the storyboard. These constants are global
    //lowercase k means a constant - recognise as a constant
    let kMarginForView:CGFloat = 10.0 //gives a 10 point margin
    let kMarginForSlot:CGFloat = 2.0
    
    let KSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0 //this is specifying the width?
    
    //new constants for the secondContainerView
    let kNumberOfContainers = 3 //3 columns
    let kNumberOfSlots = 3 //3 rows
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpContainerViews()
        setUpFirstContainer(self.firstContainer)
        setUpSecondContainer(self.secondContainer)
        
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
    //creates a new UILabel, styles it and places the label on the container
    func setUpFirstContainer(containerView: UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        //makes the label the right size to accomodate the size and font
        self.titleLabel.sizeToFit()
        // centered relative to the superview
        self.titleLabel.center = containerView.center
    //adds the containerView to the current view
        containerView.addSubview(self.titleLabel)
    }
    
    func setUpSecondContainer(containerView: UIView) {
        // the outside for loop will run three times and each time it runs the inside loop will also run three times
        // there are three containers and 3 slots
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
               var slotImageView = UIImageView() //this is a local instance not a property
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird), width: containerView.bounds.width * kThird - kMarginForSlot, height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
                
            }
        }
    }
}



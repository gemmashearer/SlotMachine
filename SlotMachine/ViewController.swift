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
    
    //properties for the third container - information labels
    var creditsLabel:UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    //buttons in fourth container
    
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    //this is creating a UIView in code rather than in the storyboard. These constants are global
    //lowercase k means a constant - recognise as a constant
    let kMarginForView:CGFloat = 10.0 //gives a 10 point margin
    let kMarginForSlot:CGFloat = 2.0
    let KSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0 //this is specifying the width?
    //these are the constants for the button
    let kHalf:CGFloat = 1.0/2.0
    let kEighth:CGFloat = 1.0/8.0
    
    //new constants for the secondContainerView
    let kNumberOfContainers = 3 //3 columns
    let kNumberOfSlots = 3 //3 rows
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpContainerViews()
        //the self.secondContainer etc links the code to the correct container
        setUpFirstContainer(self.firstContainer)
        setUpSecondContainer(self.secondContainer)
        setUpThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    //this function runs when the reset button is pressed
    func resetButtonPressed (button: UIButton) {
        
    }
    
    func betOneButtonPressed (button: UIButton) {
      
    }
    
    func betMaxButtonPressed (UIButton) {
    
    }
    
    func spinButtonPressed (UIButton) {
    
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
    
    // I don't understand any of this code
    
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
    
    func setUpThirdContainer(containerView: UIView) { // all this could be done using the IBOutlet instead
        //initialising the creditsLab
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "00000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Meno-Bold", size: 16)
        //need to set the font before calling sizeToFit
        self.creditsLabel.sizeToFit()
        //.frame is making it relative to the superview
        // to make the 6 different labels they will each have a different center
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * KSixth, y: containerView.frame.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        //initialising the betLabel 
        
        self.betLabel = UILabel()
        self.betLabel.text = "00000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        //this code puts the label at a different position on the X axis to the credits label
        self.betLabel.center = CGPoint(x: containerView.frame.width * KSixth * 3, y: containerView.frame.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        // initialising the paid label
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * KSixth * 5, y: containerView.frame.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        //initialising the credits title label
        
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "Credits"
        self.creditsTitleLabel.textColor = UIColor.blackColor()
        self.creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(x: containerView.frame.width * KSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.creditsTitleLabel)
        
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "Bet"
        self.betTitleLabel.textColor = UIColor.blackColor()
        self.betTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(x: containerView.frame.width * KSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(self.betTitleLabel)
        
        //initialising the  winner paid label
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * 5 * KSixth, y: containerView.frame.height * 2 * kThird)
        
        containerView.addSubview(self.winnerPaidTitleLabel)
        
        //fourth container = setting up a button programatically - i.e. not using the IBAction
//        
//    func setUpFourthContainer(containerView: UIView) {
//            //this is making the class UIButton
//            self.resetButton = UIButton()
//            self.resetButton.setTitle("Reset", forState: UIControlState.Normal) //the control state determines when the label will be shown
//            self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
//            //? is needed because this is an optional -  there might not be a title label
//            self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
//            self.resetButton.backgroundColor = UIColor.lightGrayColor()
//            self.resetButton.sizeToFit()
//            self.resetButton.center = CGPoint(x: containerView.frame.width * kEighth, y: containerView.frame.height * kHalf)
//            //adding a target = self (i.e. this viewController - allows us to access properties and functions inside the viewcontroller. The colon is important. resetButtonPressed is a function. TouchUpInside - for all IBACtions = default
//            self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//            containerView.addSubview(self.resetButton)
//            
//            
     }
//        
        func setupFourthContainer (containerView: UIView) {
            //code for the reset button
            self.resetButton = UIButton()
            self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
            self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
            self.resetButton.backgroundColor = UIColor.lightGrayColor()
            self.resetButton.sizeToFit()
            self.resetButton.center = CGPoint(x: containerView.frame.width * kEighth, y: containerView.frame.height * kHalf)
            self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.resetButton)
            
            //code for the bet one button
            self.betOneButton = UIButton()
            self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
            self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
            self.betOneButton.backgroundColor = UIColor.greenColor()
            self.betOneButton.sizeToFit()
            self.betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEighth, y: containerView.frame.height * kHalf)
            self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.betOneButton)
            
            self.betMaxButton = UIButton()
            self.betMaxButton.setTitle("BetMax", forState: UIControlState.Normal)
            self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
            self.betMaxButton.backgroundColor = UIColor.redColor()
            self.betMaxButton.sizeToFit()
            self.betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEighth, y: containerView.frame.height * kHalf)
            self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.betMaxButton)
            
            self.spinButton = UIButton()
            self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
            self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
            self.spinButton.backgroundColor = UIColor.greenColor()
            self.spinButton.sizeToFit()
            self.spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEighth, y: containerView.frame.height * kHalf)
            self.spinButton.addTarget(self, action: "spinButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.spinButton)
            
            

            
            
            
            
        }
    
    

        
    }
    




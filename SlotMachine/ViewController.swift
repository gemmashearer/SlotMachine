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
    
    
    //giving access to the slots array which holds Slot instances 
    
    var slots: [[Slot]] = []
    
    //stats - kep track of bets, credits and winnings
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
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
        setUpThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        //instead of secondContainer call hardReset
        hardReset()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    //this function runs when the reset button is pressed
    func resetButtonPressed (button: UIButton) {
        hardReset()
        
    }
    
    func betOneButtonPressed (button: UIButton) {
        
        if credits <= 0 {
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        } else {
            if currentBet < 5 {
                currentBet += 1
                credits -= 1
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
        
      
    }
    
    func betMaxButtonPressed (button: UIButton) {
        //checking that the user has at least enough credits to bet the max, which is 5
        if credits <= 5 {
            showAlertWithText(header: "Not Enough Credits", message: "Bet Less")
        } else {
            if currentBet < 5 {
                var creditsToBetMax = 5 - currentBet
                credits -= creditsToBetMax //updates the credits
                currentBet += creditsToBetMax //updates the bet
                updateMainView() //updates the labels
                
            } else {
                showAlertWithText(message: "You can only bet 5 credits at a time")
            }
        }
    
    }
     //will get new slots and set up the second container every time the button is pressed
    func spinButtonPressed (UIButton) {
        //remove slot image views before calling new ones
        removeSlotImageViews()
        slots = Factory.createSlots()
        setUpSecondContainer(self.secondContainer)
        
    var winningMultiplier = SlotBrain.computeWinnings(slots)
        winnings = winningMultiplier * currentBet
        credits += winnings
        currentBet = 0
        updateMainView()
        
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
                //slot returns a slot instance
                var slot:Slot
                
               var slotImageView = UIImageView() //this is a local instance not a property
                //pressing the spin button creates the slot instances
                if slots.count != 0 { //slots will != 0 when the spin button has been pressed
                    let slotContainer = slots[containerNumber]
                slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image //updates the image view with the image

                }
                else {
                    //this will show before the button is pressed
                    slotImageView.image = UIImage(named: "Ace")
                }
                
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
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
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
            //the colon that I keep forgetting tells Xcode that the selector takes a parameter
            self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            containerView.addSubview(self.spinButton)
        }
        //helper function to remove old image views before it displays new ones
        func removeSlotImageViews () {
            if self.secondContainer != nil {
                //make this an optional so that we can iterate over all of the subviews
                let container: UIView? = self.secondContainer
                let subViews:Array? = container!.subviews //slots
                for view in subViews! {
                    //will remove all of the subviews i.e. the slots added to the second container
                    view.removeFromSuperview()//superview is the second Container
                }
            }
        }
        //function to completely reset everything
    
        func hardReset () {
            removeSlotImageViews()
            //keep capacity because will will be removing slots but then addingt the same number again
            slots.removeAll(keepCapacity: true)
            self.setUpSecondContainer(self.secondContainer)
            //default stats called by hard resets.self could be used because these are properties
            credits = 50
            winnings = 0
            currentBet = 0
            
            //calling the function to update the labels
            updateMainView()
    }
    
        func updateMainView () {
            self.creditsLabel.text = "\(credits)"
            self.betLabel.text = "\(currentBet)"
            self.winnerPaidLabel.text = "\(winnings)"
            
        }
    
        func showAlertWithText (header : String = "Warning", message : String) {
            //using default alert style. creates UIAlert controller. title is the top warning
           var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            //way for the user to dismiss the alert - default action
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            //presents the alert on the screen
            self.presentViewController(alert, animated: true, completion: nil)
            
        }

    
    }
    




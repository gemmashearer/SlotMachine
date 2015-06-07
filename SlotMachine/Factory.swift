//
//  Factory.swift
//  SlotMachine
//
//  Created by Gemma Shearer on 07/06/2015.
//  Copyright (c) 2015 GemmaShearer. All rights reserved.
//

import Foundation

import UIKit

//Factory design pattern - write code to initialise instances - the factory sits in between the model, which is the slot and the viewController, which is the controller
//no class keyword = instance function. class keyword = class function. These are different: class function is called on a class, the instance function is called on an instance of a class

class Factory {
    class func createSlots() -> [[Slot]] {
        //declared as constants not properties. Inside the functions in the viewController file we declared them all as properties
        //each of the three containers will have three slots
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        //array of arrays that each holds a slot instance
        var slots: [[Slot]] = []
        //what this will look like slots = [ [slot1, slot2 etc], [], [], ]
        
        //what is going on here? creating an array of arrays which will be the variable slots.
        //once three instances of slot have been created they will be added to slotArray
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            var slotArray:[Slot] = [] //its an array of arrays because each container needs  its own array
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                //this is a class function so can be called on the factory class
                var slot = Factory.createSlot(slotArray)
                slotArray.append(slot)
            }
            slots.append(slotArray)
        }
        return slots
    }
    
    //array holds slot instances and returns a slot. we are passing in the slot array to prevent the same card from getting added to each individual array more than once but we can allow the same card to be added to each different array
    class func createSlot (currentCards : [Slot] ) -> Slot {
        //specify that this is an array that holds integers
        var currentCardValues:[Int] = []
        for slot in currentCards {
            //this is a for loop that iterates over all the instances of slot that are passed into the current cards array and then gets the value of that slot and adds it to the currentCards array
            currentCardValues.append(slot.value)
        }
        //creating a randomNumber variable  - 0 to 12
        //check if the current card value matches the random number
        var randomNumber = Int(arc4random_uniform(UInt32(13)))
        //while contains accepts 2 parameters: the array we are checking and the value we are checking for
        while contains(currentCardValues, randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        //creat slot instance
        var slot:Slot
        //switch statement for random number: each random number has its own slot instance which end up getting put in the array
        switch randomNumber {
            //don't need the file extensions anymore as these images are in the assets
        case 0: slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 1:
            slot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        case 2:
            slot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        case 3:
            slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 4:
            slot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
        case 5:
            slot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
        case 6:
            slot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
        case 7:
            slot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
        case 8:
            slot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
        case 9:
            slot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
        case 10:
            slot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
        case 11:
            slot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
        case 12:
            slot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
        default:
            slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
        }
        
        //slot with a lowercase s is one of the cards
        return slot
        }
    }

    




//calling a class function example: Factory.createSlots()

//calling an instance function - first need to create an instance: 
// var factoryInstance = Factory() (this is an instance of the factoryClass
// factoryInstance.createSlot()

//one of the points of the class function is so that you can call it without having to create an insance
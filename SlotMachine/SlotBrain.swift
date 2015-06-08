//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Gemma Shearer on 08/06/2015.
//  Copyright (c) 2015 GemmaShearer. All rights reserved.
//

import Foundation
class SlotBrain {
    class func unpackSlotsIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        
        //this code will reorganise the columnar arrays into rows
        var slotRow: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        for slotArray in slots {
            for var index = 0; index < slotArray.count; index++ {
                //[index] allows you to index into the array
                let slot = slotArray[index]
                //loops through at puts all the slots at index 0 in the first row, all at index 1 in the second row and all at index 2 in the third row
                if index == 0 {
                    slotRow.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
                else {
                    println("Error")
                }
            }
        }
        //generating a new array of arrays - the newly organised row arrays
        var slotInRows: [[Slot]] = [slotRow, slotRow2, slotRow3]
        return slotInRows
    }
    
    class func computeWinnings (slots: [[Slot]]) -> Int {
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        // flush is all red/all black
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        for slotRow in slotsInRows {
            if checkFlush(slotRow) == true {
                println("Flush")
                winnings += 1
                flushWinCount += 1
            }
            if flushWinCount == 3 {
                println("Royal flush")
                winnings += 15
            }
            
            if checkThreeInARow(slotRow) == true {
                println("Three in a row")
                winnings += 1
                straightWinCount += 1
            }
            if straightWinCount == 3 {
                println("Epic straight")
                winnings += 1000
            }
            
            if checkThreeOfAKind(slotRow) {
                println("Three of a kind")
                winnings += 3
                threeOfAKindWinCount += 1
            }
            
            if threeOfAKindWinCount == 3 {
                println("Threes all round")
                winnings += 50
            }
        }
        
        return winnings
}
    //this class func will get called in the compute winnings for loop
    class func checkFlush (slotRow: [Slot]) -> Bool {
        //setting constants to check the index in each row to see if they are all the same color
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        //if they are all red
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
            //if they are all black
        } else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
            //if they're not all red or black
        }else {
            return false
        }
    }
    
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        //getting all of the slot instances and checking the indices
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        //checking for a descending 3 in a row
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
                return true
        }
        //checking for an ascending 3 in a row
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotRow: [Slot]) -> Bool {
        //gets all the slot indices
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        // checks to see if the are all the same
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else {
         return false
        }
    }
}
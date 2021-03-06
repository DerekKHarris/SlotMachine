//
//  ViewController.swift
//  SlotMachine
//
//  Created by Derek Harris on 2/3/15.
//  Copyright (c) 2015 Derek Harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var titleLabel: UILabel!
    
        //Information labels
    var creditsLabel:UILabel!
    var betLabel:UILabel!
    var winnerPaidLabel:UILabel!
    var creditsTitleLabel:UILabel!
    var betTitleLabel:UILabel!
    var winnerPaidTitleLabel:UILabel!
    
        //buttons in fourth container
    var resetButton:UIButton!
    var betOneButton:UIButton!
    var betMaxButton:UIButton!
    var spinButton:UIButton!
    
    var slots:[[Slot]] = []
    
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    
    let kMarginForView:CGFloat = 10.0
    let kMarginForSlot:CGFloat = 2.0
    let kSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0
    let kHalf:CGFloat = 1.0/2.0
    let kEighth:CGFloat = 1.0/8.0
    
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self.setupContainerViews()
        self.setupFirstContainer(firstContainer)
        self.setupThirdContainer(thirdContainer)
        self.setupFourthContainer(fourthContainer)
        hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupContainerViews() -> () {
        firstContainer = UIView(frame: CGRect(
                    x: self.view.bounds.origin.x + kMarginForView,
                    y: self.view.bounds.origin.y + kMarginForView,
                    width: self.view.bounds.width - (kMarginForView * 2),
                    height: self.view.bounds.height * kSixth)
                                    )
        
        firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(firstContainer)
        
        secondContainer = UIView(frame: CGRect(
                    x: self.view.bounds.origin.x + kMarginForView,
                    y: firstContainer.frame.height,
                    width: self.view.bounds.width - (kMarginForView * 2),
                    height: self.view.bounds.height * (3 * kSixth))
                                    )
        
        secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(secondContainer)
        
        thirdContainer = UIView(frame: CGRect(
                    x: self.view.bounds.origin.x + kMarginForView,
                    y: firstContainer.frame.height + secondContainer.frame.height,
                    width: self.view.bounds.width - (kMarginForView * 2),
                    height: self.view.bounds.height * kSixth)
        )
        
        thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(thirdContainer)
        
        fourthContainer = UIView( frame: CGRect(
                    x: self.view.bounds.origin.x + kMarginForView,
                    y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height,
                    width: self.view.bounds.width - (kMarginForView * 2),
                    height: self.view.bounds.height * kSixth)
        )
        
        fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(fourthContainer)
        
        
    }
    
    func setupFirstContainer(containerView: UIView) -> (){
        
        titleLabel = UILabel()
        titleLabel.text = "Super Slots"
        titleLabel.textColor = UIColor.yellowColor()
        titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        titleLabel.sizeToFit()
        titleLabel.center = containerView.center
        containerView.addSubview(titleLabel)
        
    }
    
    func setupSecondContainer(containerView: UIView) -> () {
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++ {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++ {
                
                var slot:Slot
                
                var slotImageView = UIImageView()
                

                if slots.count != 0 {
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                } else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(
                        x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * kThird),
                        y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * kThird),
                        width: containerView.bounds.width * kThird - kMarginForSlot,
                        height: containerView.bounds.height * kThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
                
            }
            
        }
    }
    
    func setupThirdContainer(containerView: UIView) -> () {
        
        creditsLabel = UILabel()
        creditsLabel.text = "000000"
        creditsLabel.textColor = UIColor.redColor()
        creditsLabel.font = UIFont(name:    "Menlo-Bold", size: 16)
        creditsLabel.sizeToFit()
        creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird)
        creditsLabel.textAlignment = NSTextAlignment.Center
        creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(creditsLabel)
        
        betLabel = UILabel()
        betLabel.text = "0000"
        betLabel.textColor = UIColor.redColor()
        betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        betLabel.sizeToFit()
        betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird)
        betLabel.textAlignment = NSTextAlignment.Center
        betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(betLabel)
        
        winnerPaidLabel = UILabel()
        winnerPaidLabel.text = "000000"
        winnerPaidLabel.textColor = UIColor.redColor()
        winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        winnerPaidLabel.sizeToFit()
        winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird)
        winnerPaidLabel.textAlignment = NSTextAlignment.Center
        winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(winnerPaidLabel)
        
        creditsTitleLabel = UILabel()
        creditsTitleLabel.text = "Credits"
        creditsTitleLabel.textColor = UIColor.blackColor()
        creditsTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        creditsTitleLabel.sizeToFit()
        creditsTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(creditsTitleLabel)
        
        betTitleLabel = UILabel()
        betTitleLabel.text = "Bet"
        betTitleLabel.textColor = UIColor.blackColor()
        betTitleLabel.font = UIFont(name: "AmericanTypewriter",  size: 14)
        betTitleLabel.sizeToFit()
        betTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(betTitleLabel)
        
        winnerPaidTitleLabel = UILabel()
        winnerPaidTitleLabel.text = "Winner Paid"
        winnerPaidTitleLabel.textColor = UIColor.blackColor()
        winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        winnerPaidTitleLabel.sizeToFit()
        winnerPaidTitleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * kThird * 2)
        containerView.addSubview(winnerPaidTitleLabel)
        
    }
    

    func setupFourthContainer(containerView: UIView) -> () {
        
        resetButton = UIButton()
        resetButton.setTitle("Reset", forState: UIControlState.Normal)
        resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        resetButton.backgroundColor = UIColor.lightGrayColor()
        resetButton.sizeToFit()
        resetButton.center = CGPoint(x: containerView.frame.width * kEighth, y: containerView.frame.height * kHalf)
        resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(resetButton)
        
        betOneButton = UIButton()
        betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        betOneButton.backgroundColor = UIColor.greenColor()
        betOneButton.sizeToFit()
        betOneButton.center = CGPoint(x: containerView.frame.width * kEighth * 3, y: containerView.frame.height * kHalf)
        betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        betMaxButton = UIButton()
        betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        betMaxButton.backgroundColor = UIColor.redColor()
        betMaxButton.sizeToFit()
        betMaxButton.center = CGPoint(x: containerView.frame.width * kEighth * 5, y: containerView.frame.height * kHalf)
        betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
        
        
        spinButton = UIButton()
        spinButton.setTitle("Spin!", forState: UIControlState.Normal)
        spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        spinButton.backgroundColor = UIColor.greenColor()
        spinButton.sizeToFit()
        spinButton.center = CGPoint(x: containerView.frame.width * kEighth * 7, y: containerView.frame.height * kHalf)
        spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(spinButton)
        
        
        
        
    }
    
    func resetButtonPressed (button: UIButton) {
        hardReset()
        
    }
    
    func betOneButtonPressed (button: UIButton) {
        if credits <= 0 {
            showAlertWithText(header: "No More Credits", message: "Reset Game")
        } else {
            if currentBet < 5 {
                currentBet += 1
                //credits -= 1
                updateMainView()
            } else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
    
    }
    
    func betMaxButtonPressed (button: UIButton) {
        
        if credits < 5 {
            showAlertWithText(header: "Not Enough Credits", message: "Bet Less")
        } else {
            if currentBet < 5 {
                var creditsToBetMax = 5 - currentBet
               // credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            } else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
        
    }
    
    func spinButtonPressed (button: UIButton) {
        
        if currentBet == 0 {
            showAlertWithText(header: "Warning", message: "You need to bet before you spin!")
        } else {
        
        if credits >= currentBet {
            
            credits -= currentBet
        
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
            
            
        var computeWin = SlotBrain.computeWinnings(slots)
        var winningsMultiplier = computeWin.winnings
        var winningsMessage = computeWin.message
            
        winnings = winningsMultiplier  * currentBet
        credits += winnings
        updateMainView()
            
            if winningsMessage != "" {
                showAlertWithText(header: "Way to go!", message: winningsMessage)
            }
        }
        else {
            showAlertWithText(message: "Not enough credit for spin!")
        }
        }
        
    }
    
    func removeSlotImageViews() -> () {
        if secondContainer != nil {
            let container: UIView? = secondContainer
            let subViews:Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset() -> () {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        setupSecondContainer(secondContainer)
        
        credits = 50
        winnings = 0
        currentBet = 0
        
        updateMainView()
    }
    
    func updateMainView() {
        creditsLabel.text = "\(credits)"
        betLabel.text = "\(currentBet)"
        winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}


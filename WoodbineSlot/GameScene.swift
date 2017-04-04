//
//  GameScene.swift
//  WoodbineSlot
//
//  Created by Sagar patel on 2017-04-03.
//  Copyright © 2017 segy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var spinbtn : SKSpriteNode?
    var Diamond : SKSpriteNode?
    var Bar : SKSpriteNode?
    var Seven : SKSpriteNode?
    var one : SKSpriteNode?
    var five : SKSpriteNode?
    var ten : SKSpriteNode?
    var twentyfive : SKSpriteNode?
    var slotmac : SKSpriteNode?
    var displayres : SKLabelNode?;
    var betamt : SKLabelNode?;
    var jackpotamt : SKLabelNode?;
    var playmon : SKLabelNode?;
    var playerbetmoneycurrent = 100
    
    var playerMoney = 1000
    var winnings = 0
    var jackpot = 5000
    var turn = 0
    var playerBet = 0
    var winNumber = 0
    var lossNumber = 0
    var spinResult = [String]()
    var fruits = "";
    var winRatio = 0
    var grapes = 0
    var bananas = 0
    var oranges = 0
    var cherries = 0
    var bars = 0
    var bells = 0
    var sevens = 0
    var blanks = 0

    
    /* Utility function to show Player Stats */
   
    func resetFruitTally() {
        grapes = 0;
        bananas = 0;
        oranges = 0;
        cherries = 0;
        bars = 0;
        bells = 0;
        sevens = 0;
        blanks = 0;
    }
    
    func resetAll() {
        playerMoney = 1000;
        //displayres=[String]();
        winnings = 0;
        jackpot = 5000;
        turn = 0;
        playerBet = 0;
        winNumber = 0;
        lossNumber = 0;
        winRatio = 0;
    }
    
    
    /* Check to see if the player won the jackpot */
    func checkJackPot() {
        /* compare two random values */
        let jackPotTry = Int(arc4random_uniform(10)) + 1;
        let jackPotWin = Int(arc4random_uniform(10)) + 1;
        if (jackPotTry == jackPotWin) {
            print("***You won jackpot***")
            playerMoney += jackpot;
            jackpot = 1000;
        }
    }
    
    /* Utility function to show a win message and increase player money */
    func showWinMessage() {
         displayres?.text="";
        playerMoney += winnings;
        print("You Won: $", winnings)
        
        let displayresult = SKLabelNode(fontNamed:"Times New Roman")
        displayres?.text="You Won";
       // displayresult.text = displayres?.description
        //moneyLabel.text=" ";
        displayresult.fontSize = 14
        displayresult.position = CGPoint(x:90, y:-115)
        self.addChild(displayresult)
        self.displayres = displayresult
        displayres?.text="";
        resetFruitTally()
        checkJackPot();
    }
    
    
    
    /* Utility function to show a loss message and reduce player money */
    func showLossMessage() {
        playerMoney -= playerBet
        
        print("You Lost!")
        
        let displaylostresult = SKLabelNode(fontNamed:"Times New Roman")
        displayres?.text="You Lost";
        //displaylostresult.text = displayres?.description
        //moneyLabel.text=" ";
        displaylostresult.fontSize = 14
        displaylostresult.position = CGPoint(x:90, y:-115)
        self.addChild(displaylostresult)
        self.displayres = displaylostresult
       displayres?.text
        resetFruitTally()
    }
    
    
    
    /* Utility function to check if a value falls within a range of bounds */
    func checkRange(value : Int, lowerBounds : Int, upperBounds : Int) -> Int
    {
        var returnValue=0
        if (value >= lowerBounds && value <= upperBounds)
        {
            returnValue=value;
        }
        
        return returnValue;
    }
    
    
    
    
    
    /* When this function is called it determines the betLine results.
     e.g. Bar - Orange - Banana */
    func Reels() -> Array<String>
    {
        var betLine = [" ", " ", " "];
        var outCome = [0, 0, 0];
        
        for var spin in 0..<3 {
            outCome[spin] = Int(arc4random_uniform(60)) + 1;
            //print("random num" , outCome[spin]);
            switch (outCome[spin]) {
            case checkRange(value: outCome[spin], lowerBounds: 1, upperBounds: 27):  // 41.5% probability
                betLine[spin] = "hardluck";
                blanks += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 28, upperBounds: 37): // 15.4% probability
                betLine[spin] = "bell";
                grapes += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 38, upperBounds: 46): // 13.8% probability
                betLine[spin] = "seven";
                bananas += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 47, upperBounds: 54): // 12.3% probability
                betLine[spin] = "watermellon";
                oranges += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 55, upperBounds: 59): //  7.7% probability
                betLine[spin] = "boxer";
                cherries += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 60, upperBounds: 62): //  4.6% probability
                betLine[spin] = "lemon";
                bars += 1;		
                break;
            case checkRange(value: outCome[spin], lowerBounds: 63, upperBounds: 64): //  3.1% probability
                betLine[spin] = "cherry";
                bells += 1;
                break;
            case checkRange(value: outCome[spin], lowerBounds: 65, upperBounds: 65): //  1.5% probability
                betLine[spin] = "juice";
                sevens += 1;
                break;
                
            default:
                betLine[spin] = "hardluck";
                blanks += 1;
                break;
                
            }
        }
        return betLine;
    }
    
    /* This function calculates the player's winnings, if any */
    func determineWinnings()
    {
        if (blanks == 0)
        {
            if (grapes == 3) {
                winnings = playerBet * 10;
            }
            else if(bananas == 3) {
                winnings = playerBet * 20;
            }
            else if (oranges == 3) {
                winnings = playerBet * 30;
            }
            else if (cherries == 3) {
                winnings = playerBet * 40;
            }
            else if (bars == 3) {
                winnings = playerBet * 50;
            }
            else if (bells == 3) {
                winnings = playerBet * 75;
            }
            else if (sevens == 3) {
                winnings = playerBet * 100;
            }
            else if (grapes == 2) {
                winnings = playerBet * 2;
            }
            else if (bananas == 2) {
                winnings = playerBet * 2;
            }
            else if (oranges == 2) {
                winnings = playerBet * 3;
            }
            else if (cherries == 2) {
                winnings = playerBet * 4;
            }
            else if (bars == 2) {
                winnings = playerBet * 5;
            }
            else if (bells == 2) {
                winnings = playerBet * 10;
            }
            else if (sevens == 2) {
                winnings = playerBet * 20;
            }
            else if (sevens == 1) {
                winnings = playerBet * 5;
            }
            else {
                winnings = playerBet * 1;
            }
            winNumber += 1;
            showWinMessage();
        }
        else
        {
            lossNumber += 1;
            showLossMessage();
        }
        
    }
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        slotmac = SKSpriteNode(imageNamed: "slotmachine")
        slotmac?.size = size
        addChild(slotmac!)

        
        
        spinbtn = SKSpriteNode(imageNamed: "spinButton")
        spinbtn?.position = CGPoint(x: 10, y: -187)
        spinbtn?.scale(to: CGSize(width:50, height:50))
        self.addChild(spinbtn!)
        
        // diamond
        Diamond = SKSpriteNode(imageNamed: "hardluck")
        Diamond?.position = CGPoint(x: -90, y: -30)
        Diamond?.scale(to: CGSize(width:70, height:100))
        self.addChild(Diamond!)
        
        //star
        
        Seven = SKSpriteNode(imageNamed: "hardluck")
        Seven?.position = CGPoint(x: 0, y: -30)
        Seven?.scale(to: CGSize(width:70, height:100))
        self.addChild(Seven!)
        
        //moon
        
        Bar = SKSpriteNode(imageNamed: "hardluck")
        Bar?.position = CGPoint(x: 90, y: -30)
        Bar?.scale(to: CGSize(width:70, height:100))
        self.addChild(Bar!)
        
        //1
        
        one = SKSpriteNode(imageNamed: "bet5")
        one?.position = CGPoint(x: -90, y: -170)
        one?.scale(to: CGSize(width:40, height:40))
        self.addChild(one!)
        
        //5
        
        five = SKSpriteNode(imageNamed: "bet25")
        five?.position = CGPoint(x: -50, y: -170)
        five?.scale(to: CGSize(width:40, height:40))
        self.addChild(five!)
        
        //10
        
        ten = SKSpriteNode(imageNamed: "bet50")
        ten?.position = CGPoint(x: 60, y: -170)
        ten?.scale(to: CGSize(width:40, height:40))
        self.addChild(ten!)
        
        //25
        
        twentyfive = SKSpriteNode(imageNamed: "bet100")
        twentyfive?.position = CGPoint(x: 100, y: -170)
        twentyfive?.scale(to: CGSize(width:40, height:40))
        self.addChild(twentyfive!)
        
     
    }
    func showPlayerStats()
    {
        winRatio = winNumber / turn;
        print("Jackpot: " , jackpot);
        
        let jackpotLabel = SKLabelNode(fontNamed:"Times New Roman")
        jackpotamt?.text="";
        jackpotLabel.text = jackpot.description
        //moneyLabel.text=" ";
        jackpotLabel.fontSize = 14
        jackpotLabel.position = CGPoint(x:0, y:75)
        self.addChild(jackpotLabel)
        self.jackpotamt = jackpotLabel
        
        
        
        print("Player Money: " , playerMoney);
        let moneyLabel = SKLabelNode(fontNamed:"Times New Roman")
        playmon?.text="";
        moneyLabel.text = playerMoney.description
        //moneyLabel.text=" ";
        moneyLabel.fontSize = 14
        moneyLabel.position = CGPoint(x:-90, y:-115)
        self.addChild(moneyLabel)
        self.playmon = moneyLabel
        
        print("Total Turn: " , turn);
        print("Total Wins: " , winNumber);
        print("Total Losses: " , lossNumber);
        print("Win Ratio: " , (winRatio * 100) , "%");
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //let touch = touches.first!
            if (spinbtn?.contains(touch.location(in: self)))! {
                
                playerBet = playerbetmoneycurrent;
                
                
                if (playerMoney == 0)
                {
                    print("You ran out of Money! Do you want to play again");
                    resetAll();
                    showPlayerStats();
                }
                else if (playerBet > playerMoney) {
                    print("You don't have enough Money to place that bet.");
                }
                else if (playerBet < 0) {
                    print("All bets must be a positive $ amount.");
                }
                else if (playerBet <= playerMoney) {
                    spinResult = Reels();
                    fruits = spinResult[0] + " - " + spinResult[1] + " - " + spinResult[2];
                    //image here
                    
                    Diamond?.texture = SKTexture(imageNamed:spinResult[0])
                    Seven?.texture = SKTexture(imageNamed:spinResult[1])
                    Bar?.texture = SKTexture(imageNamed:spinResult[2])
                    print("\n\n **** 1 line Result: " ,fruits);
                    determineWinnings();
                    turn += 1;
                    showPlayerStats();
                }
                else {
                    //alert("Please enter a valid bet amount");
                }
                
                
                
                
                
                
            }
            else if (one?.contains(touch.location(in: self)))! {
                
                playerbetmoneycurrent = 5;
                let betamts = SKLabelNode(fontNamed:"Times New Roman")
                betamt?.text="";
                betamts.text = playerbetmoneycurrent.description
                //moneyLabel.text=" ";
                betamts.fontSize = 14
                betamts.position = CGPoint(x:0, y:-115)
                self.addChild(betamts)
                self.betamt = betamts
                
                
            }
            else if (five?.contains(touch.location(in: self)))! {
                
                playerbetmoneycurrent = 25;
                let betamts = SKLabelNode(fontNamed:"Times New Roman")
                betamt?.text="";
                betamts.text = playerbetmoneycurrent.description
                //moneyLabel.text=" ";
                betamts.fontSize = 14
                betamts.position = CGPoint(x:0, y:-115)
                self.addChild(betamts)
                self.betamt = betamts
                
                
                
            }
            else if (ten?.contains(touch.location(in: self)))! {
                
                playerbetmoneycurrent = 50;
                let betamts = SKLabelNode(fontNamed:"Times New Roman")
                betamt?.text="";
                betamts.text = playerbetmoneycurrent.description
                //moneyLabel.text=" ";
                betamts.fontSize = 14
                betamts.position = CGPoint(x:0, y:-115)
                self.addChild(betamts)
                self.betamt = betamts
                
                
                
            }
            else if (twentyfive?.contains(touch.location(in: self)))! {
                
                playerbetmoneycurrent = 100;
                let betamts = SKLabelNode(fontNamed:"Times New Roman")
                betamt?.text="";
                betamts.text = playerbetmoneycurrent.description
                //moneyLabel.text=" ";
                betamts.fontSize = 14
                betamts.position = CGPoint(x:0, y:-115)
                self.addChild(betamts)
                self.betamt = betamts
                
                
                
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

//
//  ViewController.swift
//  badminton scoreboard
//
//  Created by Jarvis Vizconde on 12/28/23.
//

import UIKit


//MARK: - protocols
protocol NewGameDelegate {
    //this functions will do a new game
    func backToZero()
    func dueceCheck()
    func winnerChecking()
   
}

protocol CancelDelagate {
    //this function will minus 1 the last swiped player
    func minusOne( lastPlayer : String)
}


class ViewController: UIViewController, NewGameDelegate,CancelDelagate {
    
    
    @IBOutlet weak var player1View: UIView!
    @IBOutlet weak var player2View: UIView!
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    
    
   var newGameScoreViewModel = GameMechanicsViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backToZero()
        setUpSwipeGesture()
        
        //shake undo
        becomeFirstResponder()
        
    }
    
   
   //MARK: - shake to undo
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    //declares what to do when shake stopped
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
          
            backToZero()
            dueceCheck()
        }
    }
    
    
    //MARK: - swipe up gestures to score - some obj c are used
    
    //func setting up swipe gesture
    func setUpSwipeGesture(){
        let p1SwipeUp = UISwipeGestureRecognizer(target: self, action:  #selector(leftSwipedUp))
        p1SwipeUp.direction = .up
        
        let p1SwipeDown = UISwipeGestureRecognizer(target: self, action:  #selector(leftSwipedDown))
        p1SwipeDown.direction = .down
        
        let p2SwipeUp = UISwipeGestureRecognizer(target: self, action:  #selector(rightSwipeUp))
        p2SwipeUp.direction = .up
        
        let p2SwipeDown = UISwipeGestureRecognizer(target: self, action:  #selector(rightSwipeDown))
        p2SwipeDown.direction = .down
        
        
        self.player1View?.addGestureRecognizer(p1SwipeUp)
        self.player1View?.addGestureRecognizer(p1SwipeDown)
        self.player2View?.addGestureRecognizer(p2SwipeUp)
        self.player2View?.addGestureRecognizer(p2SwipeDown)
    }
    
    @objc func leftSwipedUp(){
        //do the action when user swipe ups
         newGameScoreViewModel.gameScore.leftScore += 1
        player1.text = "\(newGameScoreViewModel.gameScore.leftScore)"
        dueceCheck()
        winnerChecking()
        
    }
    
    @objc func leftSwipedDown(){
        //do the action when user swipe down
        if newGameScoreViewModel.gameScore.leftScore > 0{
            newGameScoreViewModel.gameScore.leftScore  -= 1
            player1.text = "\(newGameScoreViewModel.gameScore.leftScore)"
            dueceCheck()
            winnerChecking()
        }
    }
    
    
    @objc func rightSwipeUp(){
        //do the action when user swipe ups
        newGameScoreViewModel.gameScore.rightScore  += 1
        player2.text = "\(newGameScoreViewModel.gameScore.rightScore)"
        dueceCheck()
        winnerChecking()
    }
    
    
    @objc func rightSwipeDown(){
        //do the action when user swipe down
        if newGameScoreViewModel.gameScore.rightScore > 0 {
            newGameScoreViewModel.gameScore.rightScore  -= 1
            player2.text = "\(newGameScoreViewModel.gameScore.rightScore)"
            dueceCheck()
            winnerChecking()
        }
    }
    
    
    
    
    
    //MARK: - protocols
    
      // 1. check  score if advantage in duece. if yes, turn background to red
    func dueceCheck() {
        
        
        if let advantage =  newGameScoreViewModel.checkAdvatage()
        {
            if advantage == "leftAdv" {
                DispatchQueue.main.async {self.player1View.backgroundColor = .red}
                DispatchQueue.main.async {self.player2View.backgroundColor = .systemGreen}
            }
            else if advantage == "rightAdv" {
                DispatchQueue.main.async {self.player2View.backgroundColor = .red}
                DispatchQueue.main.async {self.player1View.backgroundColor = .systemGreen}
            }
            else {
                DispatchQueue.main.async {self.player1View.backgroundColor = .systemGreen}
                DispatchQueue.main.async {self.player2View.backgroundColor = .systemGreen}
            }
            
            
        }
    }
    
     // 2. checking of winner if any
    func winnerChecking(){
        
        if let winnerSide =  newGameScoreViewModel.winnerCheck()
        {
            if winnerSide == "left win" {
                performSegueWinner(player: "Left" )
            }
            else if  winnerSide == "right win" {
                performSegueWinner(player: "Right" )
            }
           
        }
        
    }
   
    // 3. reset to zero
    func backToZero() {
        newGameScoreViewModel.reset()
        DispatchQueue.main.async {
            self.player1?.text = "\(self.newGameScoreViewModel.gameScore.leftScore)"
            self.player2?.text = "\(self.newGameScoreViewModel.gameScore.rightScore)"
        }
    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - segues
    
    //perform segue winner
    func performSegueWinner(player winner : String){
        newGameScoreViewModel.gameScore.winnerName = winner
        self.performSegue(withIdentifier: "winnerSegue", sender: self)
        
    }
    
    //prepare for segues
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "winnerSegue" {
              let destinationVC = segue.destination as! WinnerController
              destinationVC.cancelDelegate = self
              destinationVC.newGameDelegate = self
              destinationVC.PlayerWinner =   newGameScoreViewModel.gameScore.winnerName
              destinationVC.leftScore =  newGameScoreViewModel.gameScore.leftScore
              destinationVC.rightScore =  newGameScoreViewModel.gameScore.rightScore
              
          }
        if segue.identifier == "toAbout"{
            
                let destinationVC = segue.destination as! AboutViewController
                destinationVC.cancelDelegate = self   //passing the delegate protocols
                destinationVC.newGameDelegate = self  //passing the delegate protocols
              
        }
          
      }
    
    
    //MARK: - this will be called if the user pressed and there was a winner. the winner will be minus one
    func minusOne(lastPlayer: String) {
        
        switch lastPlayer {
            
        case "Left":
             newGameScoreViewModel.gameScore.leftScore -= 1
            DispatchQueue.main.async {self.player1?.text = "\(self.newGameScoreViewModel.gameScore.leftScore)"}
            dueceCheck()
            
        case "Right":
             newGameScoreViewModel.gameScore.rightScore -= 1
            DispatchQueue.main.async {self.player2?.text = "\(self.newGameScoreViewModel.gameScore.rightScore)" }
            dueceCheck()
            
        default:
            print("#error")
        }
        
    }

    
    
    
    @IBAction func resetButton(_ sender: Any) {
        backToZero()
        dueceCheck()
    }
    
    
    
  
    

}


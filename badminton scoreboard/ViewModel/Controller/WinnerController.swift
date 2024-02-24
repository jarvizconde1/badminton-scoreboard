//
//  WinnerController.swift
//  badminton scoreboard
//
//  Created by Jarvis Vizconde on 2/17/24.
//

import UIKit
import SAConfettiView

class WinnerController: UIViewController {

    var newGameDelegate: NewGameDelegate?
    var cancelDelegate : CancelDelagate?
    var PlayerWinner : String!
    var leftScore : Int!
    var rightScore : Int!
   

    @IBOutlet weak var confetiview: SAConfettiView!
    @IBOutlet weak var WinnerText: UILabel!
    @IBOutlet weak var leftScoreLabel: UILabel!
    @IBOutlet weak var rightScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(PlayerWinner!)
        showWinner()
        
      
        //confetti cocoapods
        confetiview.type = .Image((UIImage(named: "cock2") ?? UIImage(named: "logo"))!)
         self.confetiview.startConfetti()
        
        //shake undo, make the view as 1st responder
        becomeFirstResponder()
    }
    
    
    //MARK: - shake to undo
     override var canBecomeFirstResponder: Bool{
         return true
     }
     
     //declares what to do when shake stopped
     override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
         if motion == .motionShake {
             newGameDelegate?.backToZero()
             newGameDelegate?.dueceCheck()
             self.dismiss(animated: true, completion: nil)
         }
     }
    

    
    @IBAction func newGameButton(_ sender: Any) {
        
        //reset score and color
        newGameDelegate?.backToZero()
        newGameDelegate?.dueceCheck()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        //undo the score of winner 
        cancelDelegate?.minusOne(lastPlayer: PlayerWinner)
        self.dismiss(animated: true, completion: nil)
       
        
    }
    
    
    
    func showWinner(){
        
        if let PlayerWinnerz = PlayerWinner , let right = rightScore, let lefts = leftScore {
            
                    WinnerText.text = "\(PlayerWinnerz)"
                    rightScoreLabel.text = "\(right)"
                    leftScoreLabel.text = "\(lefts)"
            
                
            }
        }
        
    }
    
    



//
//  AboutViewController.swift
//  badminton scoreboard
//
//  Created by Jarvis Vizconde on 2/22/24.
//

import UIKit

class AboutViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //shake undo
        becomeFirstResponder()
    }
    
    var newGameDelegate: NewGameDelegate?
    var cancelDelegate : CancelDelagate?
    
    
    
    
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

    //close button
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
   
    

}

//
//  checkWinner.swift
//  badminton scoreboard
//
//  Created by Jarvis Vizconde on 2/23/24.
//

import Foundation


struct GameMechanicsViewModel {
    
    
     var gameScore = GameProperties()
    
    
        
 //MARK: - advantage checking
    func checkAdvatage() -> (String?){
        
        //left player advantage
        if (gameScore.leftScore >= 20 ) &&  ( gameScore.leftScore > gameScore.rightScore) {
            
            return ("leftAdv")
                
        }
        
        //right player advantage
        if (gameScore.rightScore >= 20 ) &&  ( gameScore.rightScore > gameScore.leftScore) {
            
            //DispatchQueue.main.async {self.player2View.backgroundColor = .red}
            return ("rightAdv")
           
        }
       
        else {
            return ("none")
        }
        
        
    }
       
    //MARK: -  winner check
    func winnerCheck() -> (String?) {
        //winner check left
        if  (gameScore.leftScore >= 21 ) && (gameScore.leftScore - gameScore.rightScore ) >= 2 || (gameScore.leftScore == 30 )   {
            
            print("Player 1 wins")
            return ( "left win")
            //   performSegueWinner(player: "Left" )
            
        }
        
        
        //winner check right
        else if (gameScore.rightScore >= 21 ) && (gameScore.rightScore - gameScore.leftScore) >= 2  || (gameScore.rightScore == 30)  {
            print("player 2 wins")
            return ("right win")
            //performSegueWinner(player: "Right" )
            
        }
        else {
            return ("none")
        }
        
    }
    
    
    
    //MARK: -  reset scores
    mutating func reset() {
         gameScore.leftScore = 0
         gameScore.rightScore = 0
        
    }
    
}

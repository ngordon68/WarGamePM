//
//  main.swift
//  WarGamePM
//
//  Created by Nick Gordon on 11/9/23.
//

/*
2 player game
 each player has 26 cards
 each player plays a card, who ever has the highest takes both cards
 and place at bottom of deck
 
 if there is a tie, both players go into war.
 each player continue to play cards until a player wins
 then the winning player takes all the cards that was played
 */

/*
 TODO
 we need cards to play
 numbers
 suits
 */

/*
 2-10
 jack - 11
 , queen - 12
 , king -13,
 ace -14
 */


import Foundation

enum Suit {
    case club
    case heart
    case diamond
    case spade
}

struct CardModel {
    let suit:Suit
    let value:Int
    
}
struct PlayerModel {
    var playerHand:[CardModel] = []
}
    
    
    var playerOne = PlayerModel(playerHand: [])
    var playerTwo = PlayerModel()


var deckOfCards:[CardModel] = []

/*
 give player half of the deck. he should have cards 1-26(0 -25)
 */

func dealCards() {
    
    for cardPosition in 0...25 {
        playerOne.playerHand.append(deckOfCards[cardPosition])
    }
    
    for cardPosition in 26...51 {
        playerTwo.playerHand.append(deckOfCards[cardPosition])
    }

}

func makeDeckOfCards() {
    for card in 2...14 {
        deckOfCards.append(CardModel(suit: .club, value: card))
    }
    for card in 2...14 {
        deckOfCards.append(CardModel(suit: .heart, value: card))
    }
    for card in 2...14 {
        deckOfCards.append(CardModel(suit: .spade, value: card))
    }
    for card in 2...14 {
        deckOfCards.append(CardModel(suit: .diamond, value: card))
    }
}

/*
 made deck
 shuffle deck
 make a player hands
 give each player 26 cards
 each player flips top card, 
 then higher value wins
 if there is a tie, players play the next cards until there is a winner
 */
/*
 1. player one wins by having higher value
 2. player two wins by having higher value
 3. theres a tie then we have to repeat round
 
 if cards are the same values, theres a tie
 keep playing until theres a winner (while loop)
 need a way to keep track of cards played during the war
 the winner of the war gets all the cards played
 declare winner (I declare war)
 
 
 */
//
var warStash:[CardModel] = []
var isNumbersTheSame:Bool = false

//this removes the top card
func goToNextCard() {
    playerTwo.playerHand.remove(at: 0)
    playerOne.playerHand.remove(at: 0)
}

func playOneRound() {
    print("round start ")
    let playerOneTopCard = playerOne.playerHand[0].value //always top card
    let playerTwoTopCard = playerTwo.playerHand[0].value
    
    if playerOneTopCard > playerTwoTopCard {
        print("Player One plays the  \(playerOne.playerHand[0].value) of \(playerOne.playerHand[0].suit) ")
        print("Player Two plays the  \(playerTwo.playerHand[0].value) of \(playerTwo.playerHand[0].suit) ")
        print("Player One wins")
        playerOne.playerHand.append(playerTwo.playerHand[0])
        playerOne.playerHand.append(playerOne.playerHand[0])
        playerOne.playerHand.append(contentsOf: warStash)
        
        warStash = []
        isNumbersTheSame = false
        goToNextCard()
        print("Player one has \(playerOne.playerHand.count) cards")
        print("Player two has \(playerTwo.playerHand.count) cards")
        
            
        
    }
    else if playerOneTopCard < playerTwoTopCard {
        print("Player One plays the  \(playerOne.playerHand[0].value) of \(playerOne.playerHand[0].suit) ")
        print("Player Two plays the  \(playerTwo.playerHand[0].value) of \(playerTwo.playerHand[0].suit) ")
        print("Player Two wins")
        playerTwo.playerHand.append(playerOne.playerHand[0])
        playerTwo.playerHand.append(playerTwo.playerHand[0])
               
        
        playerTwo.playerHand.append(contentsOf: warStash)
        
        warStash = []
        isNumbersTheSame = false
        goToNextCard()

        
        print("Player one has \(playerOne.playerHand.count) cards ")
        print("Player two has \(playerTwo.playerHand.count) cards")
                
        
    }
    else {
        isNumbersTheSame = true
        warGame()

    }
    
    print(" \n ")
}

func warGame() {
    let playerOneTopCard = playerOne.playerHand[0].value //always top card
    let playerTwoTopCard = playerTwo.playerHand[0].value //always top card
    
    while isNumbersTheSame == true {
        
        print("Player One plays the  \(playerOne.playerHand[0].value) of \(playerOne.playerHand[0].suit) ")
        print("Player Two plays the  \(playerTwo.playerHand[0].value) of \(playerTwo.playerHand[0].suit) ")
        print("Tie")
        warStash.append(playerOne.playerHand[0])
        warStash.append(playerTwo.playerHand[0])
                goToNextCard()
        playOneRound()
                    }
    
    print("we broke out of loop")
}
/*
 if cards are the same values, theres a tie
 keep playing until theres a winner (while loop)
 need a way to keep track of cards played during the war
 the winner of the war gets all the cards played
 declare winner (I declare war)
 */

func shuffleDeck() {
    deckOfCards.shuffle()
}

func playWarRounds() {
    while playerOne.playerHand.count > 0 && playerTwo.playerHand.count  > 0 {
        playOneRound()
    }
}

func determineWinner() {
    
    if playerOne.playerHand.isEmpty {
        print("Player 2 wins the game of war")
    }
    
    if playerTwo.playerHand.isEmpty {
        print("Player 1 wins the game of war")
    }
     
}
func playWarGame() {
    
    makeDeckOfCards()
    shuffleDeck()
    dealCards()
    print("Player one has \(playerOne.playerHand.count) cards at start ")
    print("Player two has \(playerTwo.playerHand.count) cards at start")
    playWarRounds()
    determineWinner()
    
  
  
}

playWarGame()



/*
 
 TODO:
 There is a FATAL ERROR when the last round is a tie.
 Try to debuff/fix the app to where the game does not break when the last round is a WAR
 Try to implement some logic to avoid fatal errors when a player has 1 card left but still has to go into war
 
 */



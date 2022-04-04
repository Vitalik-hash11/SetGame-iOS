//
//  ViewController.swift
//  SetGame
//
//  Created by newbie on 24.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let setGame = SetGame()
    
    private let shapeArray = ["▲", "●", "■"]
    private let colorArray = ["red", "green", "purple"]
    private let countArray = [1, 2, 3]
    private let shadingArray = ["filled", "outline", "striped"]
    
    var content = [NSAttributedString]()
    
    @IBOutlet weak var addThreeMoreButton: UIButton!
    @IBOutlet var cardList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        guard let selectedCardIndex = cardList.firstIndex(of: sender) else {
            fatalError()
        }
        setGame.selectCard(at: selectedCardIndex)
        updateUI()
    }
    
    @IBAction func addThreeMoreCardsPressed(_ sender: UIButton) {
        setGame.addThreeMoreCards()
        updateUI()
    }
    
    @IBAction func newGamePressed(_ sender: UIBarButtonItem) {
        // TODO: clear deck
    }
    
    
    private func updateUI() {
        navigationItem.title = "Score: \(setGame.score)"
        for index in setGame.playedCards.indices {
            let card = setGame.playedCards[index]
            let uiCard = cardList[index]
            uiCard.layer.borderWidth = 0
            var string = ""
            for _ in 0...card.countIdentifier {
                string.append(contentsOf: shapeArray[card.shapeIdentifier])
            }
            
            var attributes = [
                .font: UIFont.systemFont(ofSize: 35),
            ] as [NSAttributedString.Key : Any]
            
            switch shadingArray[card.shadingIdentifier] {
            case "filled":
                attributes[.foregroundColor] = UIColor(named: colorArray[card.colorIdentifier])
            case "outline":
                attributes[.foregroundColor] = UIColor(named: colorArray[card.colorIdentifier])
                attributes[.strokeWidth] = 4
            case "striped":
                attributes[.foregroundColor] = UIColor(named: colorArray[card.colorIdentifier])?.withAlphaComponent(0.15)
            default:
                fatalError("Strange shading")
            }
            
            if card.isSelected {
                uiCard.layer.borderWidth = 3
                uiCard.layer.borderColor = UIColor.cyan.cgColor
                if setGame.selectedCards.count == 3 {
                    if setGame.isCurrentlySelectedCardsMatch {
                        uiCard.layer.borderColor = UIColor.green.cgColor
                    } else {
                        uiCard.layer.borderColor = UIColor.red.cgColor
                    }
                }
            }
            
            uiCard.isHidden = false
            uiCard.backgroundColor = UIColor.white
            uiCard.setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: .normal)
            uiCard.titleLabel?.layer.opacity = 1.0
        }
        for index in setGame.playedCards.count..<cardList.count {
            let uiCard = cardList[index]
            uiCard.backgroundColor = .clear
            uiCard.titleLabel?.layer.opacity = 0.0
            uiCard.layer.borderWidth = 0
        }
        if setGame.playedCards.count == 24 || setGame.cardsDeck.isEmpty {
            addThreeMoreButton.isEnabled = false
        }
    }
    
}

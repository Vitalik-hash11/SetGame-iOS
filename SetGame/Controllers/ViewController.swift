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
    
    private func updateUI() {
        for index in setGame.playedCards.indices {
            let card = setGame.playedCards[index]
            let uiCard = cardList[index]
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
            } else {
                uiCard.layer.borderWidth = 0
            }
            
            uiCard.isHidden = false
            uiCard.backgroundColor = UIColor.white
            uiCard.setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: .normal)
        }
        if setGame.playedCards.count == 24 {
            addThreeMoreButton.isEnabled = false
        }
    }
    
}

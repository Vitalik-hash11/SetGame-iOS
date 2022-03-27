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
    
    @IBOutlet var cardList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in setGame.playedCards.indices {
            let card = setGame.playedCards[index]
            let uiCard = cardList[index]
            var string = ""
            for _ in 0...card.countIdentifier {
                string.append(contentsOf: shapeArray[card.shapeIdentifier])
            }
            
            var attributes = [
                .font: UIFont.systemFont(ofSize: 40),
            ] as [NSAttributedString.Key : Any]
            
            switch shadingArray[card.shadingIdentifier] {
            case "filled":
                attributes[.foregroundColor] = UIColor(named: colorArray[card.colorIdentifier])
            case "outline":
                attributes[.foregroundColor] = UIColor(named: colorArray[card.colorIdentifier])
                attributes[.strokeWidth] = 3
            case "striped":
                attributes[.foregroundColor] = UIColor(named: colorArray[card.colorIdentifier])?.withAlphaComponent(0.15)
            default:
                fatalError("Strange shading")
            }
            uiCard.setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: .normal)
        }
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        //TODO: handle card selection
    }
    
    
}

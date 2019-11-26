//
//  ViewController.swift
//  ColorMemory
//
//  Created by Alex Cheung on 25/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // Mark: - Outlet
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var logoImageVIew: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameStartButton: UIButton!
    @IBOutlet weak var highScoreButton: UIButton!
    
    // Marks:- Variable
    let game = Game()
    var cards = [Card]()
    var scoreboard = Score()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNewGame()
        self.setupTopLayer()
        self.setupCardCollectionViewUI()
        
        createRankListData()
        fetchRankList()
        sortRankList()
    }

    func setupNewGame() {
        scoreboard = Score()
        scoreLabel.text = String(scoreboard.score)
        cards = game.newGame()
        cardCollectionView.reloadData()
    }
    
    func resetGame() {
        game.restartGame()
        setupNewGame()
    }

    @IBAction func tapOnGameStartButton(_ sender: Any) {
        cardCollectionView.isHidden = false
        scoreLabel.isHidden = false
        gameStartButton.isHidden = true
    }
}

// MARK: -For CollectionView

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        
        cell.cardId = cards[indexPath.row].id
        cell.isShown = cards[indexPath.row].shown
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell
        let selectedCard = cards[indexPath.row]
        var isMatched: Bool? = nil
    
        // Flip the card Action
        if selectedCard.shown == false {
            
            // Instant UI changed
            selectedCard.shown = true
            cell.isShown = true
            
            // Delay for 1 sec
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                isMatched = self.game.didSelectCard(selectedCard)
                
                if isMatched == true {
                    cell.isMatched = true
                    
                    self.gameHideCards(self.game, cards: self.game.cardsShown)
                    
                    self.scoreboard.score += 5
                    self.scoreLabel.text = String(self.scoreboard.score)
                    
                    //Check End Game
                    if self.game.cardsShown.count == self.game.cards.count {
                        self.gameDidEnd(self.game)
                    }

                } else if isMatched == false {
                    // Flip the 2 card back
                    self.gameShowCards(self.game, cards: self.game.cardsSelected)
                    self.game.cardsSelected.removeAll()
                    
                    // Deduct point
                    self.scoreboard.score -= 1
                    self.scoreLabel.text = String(self.scoreboard.score)
                }
            }
        } else {
            // Already Selected Card
            print("this is a shown card")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size: Int
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        } else {
            size = Int((collectionView.bounds.height - totalSpace) / CGFloat(noOfCellsInRow))
        }
        
        return CGSize(width: size, height: size)
    }
    
    // MARK: For autolayout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let portraitWidthConstraint: CGFloat
        let landscapeHeightConstraint: CGFloat
        
        if UIApplication.shared.statusBarOrientation.isPortrait {
            portraitWidthConstraint =  view.frame.size.width * 0.7
            landscapeHeightConstraint = view.frame.size.width * 0.7
        } else {
            portraitWidthConstraint =  view.frame.size.height * 0.7
            landscapeHeightConstraint = view.frame.size.height * 0.7
            
        }
        
        if UIApplication.shared.statusBarOrientation.isPortrait { //changed
           cardCollectionView.widthAnchor.constraint(equalToConstant: landscapeHeightConstraint).isActive = false
           cardCollectionView.heightAnchor.constraint(equalToConstant: landscapeHeightConstraint).isActive = false
           cardCollectionView.widthAnchor.constraint(equalToConstant: portraitWidthConstraint).isActive = true
           cardCollectionView.heightAnchor.constraint(equalToConstant: portraitWidthConstraint).isActive = true
            
        } else if UIApplication.shared.statusBarOrientation.isLandscape {
            cardCollectionView.widthAnchor.constraint(equalToConstant: portraitWidthConstraint).isActive = false
            cardCollectionView.heightAnchor.constraint(equalToConstant: portraitWidthConstraint).isActive = false
            cardCollectionView.widthAnchor.constraint(equalToConstant: landscapeHeightConstraint).isActive = true
            cardCollectionView.heightAnchor.constraint(equalToConstant: landscapeHeightConstraint).isActive = true
            
            cardCollectionView.layoutIfNeeded()
        }
    }
    
    func setupTopLayer() {
        self.scoreLabel.isHidden = true
        self.scoreLabel.text = String(scoreboard.score)
    }
    
    func setupCardCollectionViewUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        
        cardCollectionView.collectionViewLayout = layout
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        cardCollectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        cardCollectionView.backgroundColor = .white
        cardCollectionView.isHidden = true
        self.view.addSubview(cardCollectionView)
        
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardCollectionView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        cardCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
    }
}
    
extension GameViewController {

    func gameShowCards (_ game: Game, cards: [Card]) {
        for card in cards {
            guard let index = game.returnCardPosition(card) else { continue }

            let cell = cardCollectionView.cellForItem(at: IndexPath(item: index, section:0)) as! CardCell
            cell.isMatched = false
            cell.isShown = false
            game.cards[index].shown = false
        }
    }

    func gameHideCards (_ game: Game, cards: [Card]) {
        for card in cards {
            guard let index = game.returnCardPosition(card) else { continue }
            let cell = cardCollectionView.cellForItem(at: IndexPath(item: index, section:0)) as! CardCell
            cell.isMatched = true
        }
    }

    func gameDidEnd(_ game: Game) {
        let playerRank = calculateCurrentPlayerRank(playerScore: scoreboard.score)
        
        let alert = UIAlertController(title: "You Win",
                                      message: "Your score: \(scoreboard.score)\nYour Rank: \(playerRank)",
                                        preferredStyle: .alert)

        alert.addTextField {
            $0.placeholder = "Input your name"
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }

        let loginAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            guard let name = alert.textFields?[0].text else { return } // Should never happen

            // Perform login action
            self.scoreboard.username = name
            self.appendNewScoreToList()
            self.saveRankListToUserDefault()

            self.cardCollectionView.isHidden = true
            self.gameStartButton.isHidden = false
            self.scoreLabel.isHidden = true
            self.resetGame()
        }

        loginAction.isEnabled = false
        alert.addAction(loginAction)
        present(alert, animated: true)
    }
    
    // Mark:- RankList
    
    func createRankListData() {
        rank.rankList = [Score(username: "Player A", score: 1),
                         Score(username: "Player B", score: 20),
                         Score(username: "Player C", score: -5)
                        ]
    }
    
    func appendNewScoreToList() {
        let newScore = Score(username: scoreboard.username,
                             score: scoreboard.score)
        
        rank.rankList.append(newScore)
        sortRankList()
    }
    
    func saveRankListToUserDefault() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(rank.rankList), forKey:"rankList")
    }
    
    func fetchRankList() {
        if let data = UserDefaults.standard.value(forKey:"rankList") as? Data {
            let fetchedRankList = try? PropertyListDecoder().decode(Array<Score>.self, from: data)
            rank.rankList = fetchedRankList!
        }
    }
    
    
    func calculateCurrentPlayerRank(playerScore: Int) -> Int {
        sortRankList()
        let scoreList = rank.rankList.map{$0.score}
        
        var rank = 1
        for score in scoreList {
            if playerScore > score {
                return rank
            } else {
                rank += 1
            }
        }
        return 0
    }
    
    func sortRankList() {
        let sortedRankList = rank.rankList.sorted(by: {$0.score > $1.score})
        rank.rankList = sortedRankList
    }

}



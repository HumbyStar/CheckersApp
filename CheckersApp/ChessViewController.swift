//
//  TesteViewController.swift
//  CheckersApp
//
//  Created by Humberto Rodrigues on 02/02/23.
//

import UIKit

class ChessViewController: UIViewController {
    // O que faltou fazer no meu tabuleiro ? Associar o BoardView a UIView e criar as constrains do BoardView, intanciar a ChessController
    var chessController = ChessControler()
    var sender: UIButton?
    var point: CGPoint?
    var hadImage: Bool = false
    
    //-------------------------------|
    var l: Int?
    var c: Int?
    //-------------------------------|
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        chessController.chessViewController = self
        
        for linha in 0...7 {
            for coluna in 0...7 {
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
                panGesture.delegate = self
                chessController.chess.squares[linha][coluna].addGestureRecognizer(panGesture)
            }
        }
       
       
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        if let selectedTouch = gesture.view as? UIButton { //To tratando gesture.view como um botão
            let chess = chessController.chess
            switch gesture.state {
            case .began:
                if selectedTouch.image(for: .normal) == nil {
                    print("Ignora não tem imagem")
                    self.hadImage = false
                } else {
                    selectedTouch.setImage(nil, for: .normal)
                    self.hadImage = true
                }
            case .changed:
                self.point = gesture.location(in: chess.boardView)
                findButton()
            case .ended:
                guard let l = l, let c = c else {return}
                print(c,l)
                if hadImage {
                    if chess.squares[c][l].backgroundColor == .white {
                        chess.squares[l][c].setImage(UIImage(named: "DamaPreta"), for: .normal)
                        //chess.squares[l][c].backgroundColor = .purple
                    } else {
                        chess.squares[l][c].setImage(UIImage(named: "DamaBranca"), for: .normal)
                        //chess.squares[l][c].backgroundColor = .orange
                    }
                }
            default:
                break
            }
        }
    }
    
    func findButton() {
        guard let point = point else {return}
        for c in 0...7 {
            for l in 0...7 {
                if chessController.chess.squares[l][c].frame.contains(point) {
                    self.l = l
                    self.c = c
                }
            }
        }
    }

    func setupView() {
        view.backgroundColor = .white
        chessController.chess.boardView.translatesAutoresizingMaskIntoConstraints = false
        chessController.chess.boardView.layer.borderWidth = 5
        chessController.chess.boardView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(chessController.chess.boardView)
        setBorderConstrains()
        chessController.showBorder()
    }
    
    func setBorderConstrains() {
        NSLayoutConstraint.activate([
            chessController.chess.boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chessController.chess.boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chessController.chess.boardView.widthAnchor.constraint(equalToConstant: 400),
            chessController.chess.boardView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func tappedInButton(_ sender: UIButton) {
        self.sender = sender
        let linha = sender.tag/8
        let coluna = sender.tag%8
        print(coluna, linha)
        
    }
}

extension ChessViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, didChange state: UIGestureRecognizer.State) {
    }
}

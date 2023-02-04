//
//  ChessController.swift
//  CheckersApp
//
//  Created by Humberto Rodrigues on 02/02/23.
//

import UIKit

class ChessControler {
    var chess: Chess
    
    weak var chessViewController: ChessViewController?
    
    init() {
        self.chess = Chess()
    }
    
    private func buildBoard() {
        for linha in 0...7 {
            for coluna in 0...7 {
                let quadrado = UIButton()
                quadrado.tag = (linha*8) + coluna
                quadrado.translatesAutoresizingMaskIntoConstraints = false
                quadrado.backgroundColor = (linha + coluna) % 2 == 0 ? .white : .black
                
                if (linha + coluna) % 2 == 0 && (coluna == 0 || coluna == 1 || coluna == 2) {
                    quadrado.setImage(UIImage(named:"DamaPreta"), for: .normal)
                } else if (linha + coluna) % 2 != 0 && (coluna == 5 || coluna == 6 || coluna == 7) {
                    quadrado.setImage(UIImage(named:"DamaBranca"), for: .normal)
                }
                
                quadrado.addTarget(self, action: #selector(tappedInSquares), for: .touchUpInside)
                chess.boardView.addSubview(quadrado)
                NSLayoutConstraint.activate([
                    quadrado.widthAnchor.constraint(equalToConstant: 50),
                    quadrado.heightAnchor.constraint(equalToConstant: 50),
                    quadrado.leadingAnchor.constraint(equalTo: chess.boardView.leadingAnchor , constant: CGFloat((linha)*50)),
                    quadrado.topAnchor.constraint(equalTo: chess.boardView.topAnchor, constant: CGFloat((coluna)*50))
                ])
                chess.squares[linha][coluna] = quadrado
            }
        }
    }
    
    
    func showBorder() {
        buildBoard()
    }
    
    @objc func tappedInSquares(_ sender: UIButton) {
        //MARK: Envio esse Sender pra la
        chessViewController?.tappedInButton(sender)
    }
}

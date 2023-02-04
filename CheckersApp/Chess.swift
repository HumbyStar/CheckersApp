//
//  Chess.swift
//  CheckersApp
//
//  Created by Humberto Rodrigues on 02/02/23.
//

import UIKit

struct Chess {
    var squares: [[UIButton]]
    var boardView: UIView
    
    init() {
        let button = UIButton()
        self.squares = Array(repeating: Array(repeating: button, count: 8), count: 8)
        self.boardView = UIView()
    }
}

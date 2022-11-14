//
//  Array+Extensions.swift
//  FDJLeagues
//
//  Created by Mickael Mas on 14/11/2022.
//

import Foundation

extension Array {
    /* 5- Affichagedelalistedeséquipesduchampionnattriéesparordreanti-alphabétique
    en n’affichant qu’1 équipe sur 2. */

    func filteredOneOutOfTwo() -> [Element] {
        if self.isEmpty { return [] }
        var values = [Element]()
        for (index, element) in self.enumerated() {
            if index.isMultiple(of: 2) {
                values.append(element)
            }
        }
        return values
    }
}

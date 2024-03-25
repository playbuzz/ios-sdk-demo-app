//
//  OptionListCellModel.swift
//  HostApp
//
//  Created by Eli Mehaudy on 25/12/2023.
//

import Foundation

struct OptionListCellModel {
    private let id = UUID()
    let title: String
    let text: String?
    var action: (() -> Void)?
}

extension OptionListCellModel: Hashable {
    static func == (lhs: OptionListCellModel, rhs: OptionListCellModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

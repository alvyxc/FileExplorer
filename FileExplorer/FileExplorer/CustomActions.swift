//
//  ExternalActions.swift
//  FileExplorer
//
//  Created by Alvy Chen on 6/28/20.
//

import Foundation

public struct CustomAction {
    var actionTitle: String
    var minItemsRequired: Int
    var maxItemsAllowed: Int
    var isActionInProgress: Bool
    
    public init(actionTitle: String) {
        self.actionTitle = actionTitle
        self.minItemsRequired = 1
        self.maxItemsAllowed = Int.max
        self.isActionInProgress = false
    }
    
    public mutating func setMinItemsRequired(num: Int) {
        self.minItemsRequired = num
    }
    
    public mutating func setMaxItemsAllowed(num: Int) {
        self.maxItemsAllowed = num
    }
    
    public mutating func setActionProgress(inProgress: Bool) {
        self.isActionInProgress = inProgress
    }
}

public class CustomActions {
    var renameAction: CustomAction?
    var shareAction: CustomAction?
    init() {
        // Empty init value
    }
}

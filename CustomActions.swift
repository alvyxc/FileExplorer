//
//  ExternalActions.swift
//  FileExplorer
//
//  Created by Alvy Chen on 6/28/20.
//

import Foundation

public struct CustomAction {
    var actionTitle: String
    var itemsRequired: Int
    var isActionInProgress: Bool
    
    public init(actionTitle: String) {
        self.actionTitle = actionTitle
        self.itemsRequired = 1
        self.isActionInProgress = false
    }
    
    public mutating func setItemRequired(num: Int) {
        self.itemsRequired = num
    }
    
    public mutating func setActionProgress(inProgress: Bool) {
        self.isActionInProgress = inProgress
    }

}

public class CustomActions {
    var action1: CustomAction?
    var action2: CustomAction?
    init() {
        // Empty init value
    }
}

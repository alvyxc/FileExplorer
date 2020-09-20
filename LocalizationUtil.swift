//
//  LocalizationUtil.swift
//  FileExplorer
//
//  Created by Alvy Chen on 9/13/20.
//

import Foundation

class LocalizationUtil {
    
    static func getLocationStr(key: String) -> String {
        
        return NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}

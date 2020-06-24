//
//  Contact.swift
//  Chat App for iOS 10
//
//  Created by apple on 6/7/18.
//  Copyright © 2018 Frank Nerdy. All rights reserved.
//

import Foundation

class Contact {
    
    private var _name = "";
    private var _id = "";
    
    init(id: String, name: String) {
        _id = id;
        _name = name;
    }
    
    var name: String {
        get {
            return _name;
        }
    }
    var id: String {
        return _id;
    }
}

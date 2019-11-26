//
//  Rank.swift
//  ColorMemory
//
//  Created by Alex Cheung on 26/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

let rank = Rank.sharedInstance
private var _SingletonSharedInstance =  Rank()

class Rank {
    
    public class var sharedInstance : Rank {
        return _SingletonSharedInstance
    }
    
    var rankList = [Score]()
}

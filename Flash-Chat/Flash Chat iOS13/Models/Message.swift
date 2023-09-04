//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by Sergei Semko on 8/3/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import Foundation

enum Sender {
    case me, you
}

struct Message {
    let sender: String
    let body: String
}

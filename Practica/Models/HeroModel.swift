//
//  HeroModel.swift
//  Practica
//
//  Created by Nicolas on 13/07/22.
//
import UIKit

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool
}

struct Transformation: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let hero: HeroID
    
    struct HeroID: Decodable {
        let id: String
    }
}

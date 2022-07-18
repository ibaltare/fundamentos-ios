//
//  LocalDataModel.swift
//  Practica
//
//  Created by Nicolas on 13/07/22.
//

import Foundation

private enum Constant {
  static let Email = "email"
}

final class LocalDataModel {
  private static let userDefaults = UserDefaults.standard
  
  static func getEmail() -> String? {
    userDefaults.string(forKey: Constant.Email)
  }
  
  static func save(email: String) {
    userDefaults.set(email, forKey: Constant.Email)
  }
  
  static func deleteEmail() {
    userDefaults.removeObject(forKey: Constant.Email)
  }
}

//
//  UserDefaultsService.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.09.2022.
//

import Foundation


class UserDefaultsService {
    
    
    func saveTokenToDefaults(token:String) {
        UserDefaults.standard.set(token, forKey: UserDefaultsEnum.token.rawValue)
    }
    
    func removeTokenFromDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsEnum.token.rawValue)
    }
    
    func loadTokenFromDefaults() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsEnum.token.rawValue) ?? ""
    }
    
    func isUserLogged() -> Bool {
        return self.loadTokenFromDefaults() != ""
    }
    
    func isOnboarded() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsEnum.onboarded.rawValue)
    }
    
    func markAsOnboarded() {
        UserDefaults.standard.set(true, forKey: UserDefaultsEnum.onboarded.rawValue)
    }
}

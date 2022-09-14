//
//  UserDefaultsService.swift
//  Move
//
//  Created by Preoteasa Ioan-Silviu on 09.09.2022.
//

import Foundation


class UserDefaultsService {
    
    func loadUserFromDefaults() throws -> LoggedUser? {
        guard let encodedUser = UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue) as? Data else {
            return nil
        }
        let decodedUser = try JSONDecoder().decode(LoggedUser.self, from: encodedUser)
        return decodedUser
    }
    
    func removeUserFromDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsEnum.loggedUser.rawValue)
    }
    
    func isOnboarded() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsEnum.onboarded.rawValue)
    }
    
    func userIsLogged() -> Bool {
        
        return (try? loadUserFromDefaults()) != nil
    }
    
    func markAsOnboarded() {
        UserDefaults.standard.set(true, forKey: UserDefaultsEnum.onboarded.rawValue)
    }
    
    func markAsValidated() {
        let encodedUser = UserDefaults.standard.value(forKey: UserDefaultsEnum.loggedUser.rawValue)
        var user = try? JSONDecoder().decode(LoggedUser.self, from: encodedUser as! Data)
        user!.user.validated = true
        if let encoded = try? JSONEncoder().encode(user!) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsEnum.loggedUser.rawValue)
        }
    }
}

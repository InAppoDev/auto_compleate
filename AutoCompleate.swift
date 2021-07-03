//
//  AutoCompleateManager.swift
//  BarCode
//
//  Created by Developer on 24.01.2021.
//

import Foundation

class AutoCompleateEntity: NSObject, NSCoding {
	let login: String
	let password: String
	
	init(login: String, password: String) {
			self.login = login
			self.password = password
		}

		required convenience init(coder aDecoder: NSCoder) {
			let password = aDecoder.decodeObject(forKey: "password") as! String
			let login = aDecoder.decodeObject(forKey: "login") as! String
			self.init(login: login, password: password)
		}

		func encode(with aCoder: NSCoder) {
			aCoder.encode(login, forKey: "login")
			aCoder.encode(password, forKey: "password")
		}
}

class AutoCompleateManager {
	
	static let shared = AutoCompleateManager()
	
	var userDefaults = UserDefaults.standard
	
	private init() { }
	
	func saveEntity(entity: AutoCompleateEntity) {
		let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: entity)
		userDefaults.set(encodedData, forKey: "auto_compleate")
	}
	
	func getEntity() -> AutoCompleateEntity? {
		if let decoded  = userDefaults.data(forKey: "auto_compleate") {
			let decoded = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! AutoCompleateEntity
			return decoded
		}
		return nil
	}
}

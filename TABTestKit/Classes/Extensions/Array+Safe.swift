//
//  Array+Safe.swift
//  TABTestKit
//
//  Created by Kane Cheshire on 07/11/2019.
//

import Foundation

extension Array {

	/// Safely retrieves an element by index.
	/// If the index does not exist in the array's indices,
	/// nil is retured rather than crashing the app.
	subscript(_ index: Index) -> Element? {
		if indices.contains(index) {
			return self[index] as Element // Required cast to stop an infinite loop of using the wrong subscript here
		}
		return nil
	}

}

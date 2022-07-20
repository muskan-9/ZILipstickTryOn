//
//  ZIProductEntity.swift
//  ZILipstickTryOn
//
//  Created by Muskan Jain on 28/06/22.
//

import Foundation


struct ZIProductEntity: Decodable {
    let data: ZIProductData?
    let message: String?
    let status: String?
}

struct ZIProductData: Decodable {
    let media: ZIProductMedia?
    let summary: ZIProductSummary?
    let availableColors: ZIProductAvailableColors?
}

struct ZIProductMedia: Decodable {
    let values: [ZIProductMediaValue]?
    let count: Int?
}

struct ZIProductSummary: Decodable {
    let name: String?
}

struct ZIProductAvailableColors: Decodable {
    let values: [ZIProductAvailableColorsValue]?
    let count: Int?
}

struct ZIProductMediaValue: Decodable {
    let extraLarge: String?
}

struct ZIProductAvailableColorsValue: Decodable {
    let swatch: String?
    let color: String?
}



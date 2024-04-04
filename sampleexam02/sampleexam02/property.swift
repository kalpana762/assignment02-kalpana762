//
//  property.swift
//  sampleexam02
//
//  Created by kalpana on 4/4/24.
//

import Foundation

struct property{
    let name: String
    let propertyImage: String
    let address: String
    let price: Double
    let numberOfBedrooms: Int
    let numberOfBathrooms: Int
    
    
    static var data:[property]=[
        property(name: "Property1", propertyImage: "property1", address: "123 Main st", price: 500000, numberOfBedrooms: 03, numberOfBathrooms: 02),
    property(name: "Property2", propertyImage: "property2", address: "123 Quin st", price: 600000, numberOfBedrooms: 04, numberOfBathrooms: 01),
    property(name: "Property3", propertyImage: "property3", address: "456 Maple Ave", price: 750000, numberOfBedrooms: 04, numberOfBathrooms: 03),
    property(name: "Property4", propertyImage: "property4", address: "456 Mulberry Ave", price: 800000, numberOfBedrooms: 05, numberOfBathrooms: 02),
        property(name: "Property5", propertyImage: "property5", address: "789 Oak st", price: 1100000, numberOfBedrooms: 05, numberOfBathrooms: 04),
    property(name: "Property6", propertyImage: "property6", address: "321 Elm st", price: 1500000, numberOfBedrooms: 09, numberOfBathrooms: 05),
    ]
    
    static var first:[property]=[]
    static var second:[property]=[]
    static var Third:[property]=[]
    static var purchased:[property]=[]
    
    static var section=["$500,000 - $750,000","$750,000 - $1,000,000","over $1,000,000","purchased"]
    
    
}

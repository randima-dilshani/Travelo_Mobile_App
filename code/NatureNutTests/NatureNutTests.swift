//
//  NatureNutTests.swift
//  NatureNutTests
//
//  Created by Randima Dilshani on 2023-06-15.
//

import XCTest
import CoreData
@testable import NatureNut

final class DataControllerTests: XCTestCase {
    var dataController: DataController!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
           dataController = DataController()
           context = dataController.container.viewContext
       }

       override func tearDownWithError() throws {
          
           let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Nature")
                   let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                   try context.execute(deleteRequest)
               }

    func testAddNature() throws {
        // Given
        let name = "Nature 1"
        let place = "Park"
        let kilometers: Double = 10.5
        let type = "Plants"

        // When
        dataController.addNature(name: name, place: place, kilometers: kilometers, type: type, context: context)

        // Then
        let fetchRequest: NSFetchRequest<Nature> = NSFetchRequest(entityName: "Nature")
                let results = try context.fetch(fetchRequest)
                XCTAssertEqual(results.count, 1)
                XCTAssertEqual(results.first?.name, name)
                XCTAssertEqual(results.first?.place, place)
                XCTAssertEqual(results.first?.kilometers, kilometers)
                XCTAssertEqual(results.first?.type, type)
            }
    func testEditNature() throws {
        // Given
        let originalName = "Nature 1"
        let newName = "Updated Nature"
        let place = "Park"
        let originalKilometers: Double = 10.5
        let updatedKilometers: Double = 15.0
        let type = "Plants"

        // Add a nature entry to the context
        let nature = Nature(context: context)
        nature.name = originalName
        nature.place = place
        nature.kilometers = originalKilometers
        nature.type = type
        try context.save()

        // When
        dataController.editNature(nature: nature, name: newName, place: place, kilometers: updatedKilometers, type: type, context: context)
        // Then
        let fetchRequest: NSFetchRequest<Nature> = NSFetchRequest(entityName: "Nature")
                let results = try context.fetch(fetchRequest)
                XCTAssertEqual(results.count, 1)
                XCTAssertEqual(results.first?.name, newName)
                XCTAssertEqual(results.first?.place, place)
                XCTAssertEqual(results.first?.kilometers, updatedKilometers)
                XCTAssertEqual(results.first?.type, type)
            }
        }

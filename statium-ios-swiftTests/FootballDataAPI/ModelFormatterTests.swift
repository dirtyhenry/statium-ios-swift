@testable import statium_ios_swift
import XCTest

class ModelFormatterTests: XCTestCase {
    func testValidDate() {
        let sut = ModelFormatter.dateFormatter.date(from: "2020-08-22")
        XCTAssertEqual(Calendar.current.component(.year, from: sut!), 2020)
        XCTAssertEqual(Calendar.current.component(.month, from: sut!), 8)
        XCTAssertEqual(Calendar.current.component(.day, from: sut!), 22)
    }
    
    func testInvalidDate() {
        let sut = ModelFormatter.dateFormatter.date(from: "fart")
        XCTAssertNil(sut)
    }

    func testInvalidMonthAndDayEdgeCases() {
        XCTAssertNil(ModelFormatter.dateFormatter.date(from: "2020-13-33"))
    }
    
    func testYearRangeWithDifferentYears() {
        XCTAssertEqual(
            ModelFormatter.yearRange(
                from: ModelFormatter.dateFormatter.date(from: "2020-08-22")!,
                to: ModelFormatter.dateFormatter.date(from: "2021-05-23")!
            ),
            "2020-2021"
        )
    }

    func testYearRangeWithSameYears() {
        XCTAssertEqual(
            ModelFormatter.yearRange(
                from: ModelFormatter.dateFormatter.date(from: "2020-08-22")!,
                to: ModelFormatter.dateFormatter.date(from: "2020-09-23")!
            ),
            "2020"
        )
    }
}

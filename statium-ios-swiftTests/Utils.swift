import Foundation

enum TestError: Error {
    case noURLForResource
}

extension Bundle {
    func jsonData(forResource name: String?, withExtension ext: String? = "json") throws -> Data {
        guard let jsonURL = url(forResource: name, withExtension: ext) else {
            throw TestError.noURLForResource
        }

        return try Data(contentsOf: jsonURL)
    }
}

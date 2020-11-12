import Foundation

/**
 * This enum provides a convenient way to access configuration values at runtime.
 *
 * Cf. https://nshipster.com/xcconfig/
 */
enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    fileprivate static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

// swiftlint:disable force_try
enum FootballDataAPIConfiguration {
    static var authToken: String {
        return try! Configuration.value(for: "FOOTBALL_DATA_API_AUTH_TOKEN")
    }

    static var plan: FootballData.Plan {
        let rawValue: String = try! Configuration.value(for: "FOOTBALL_DATA_API_PLAN")
        guard let res = FootballData.Plan(rawValue: rawValue) else {
            fatalError("Invalid value \(rawValue) to identify football data plan.")
        }
        return res
    }
}
// swiftlint:enable force_try

extension FootballData {
    static func new() -> FootballData {
        return FootballData(
            authToken: FootballDataAPIConfiguration.authToken,
            plan: FootballDataAPIConfiguration.plan
        )
    }
}

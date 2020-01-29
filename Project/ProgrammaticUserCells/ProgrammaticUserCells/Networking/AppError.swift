import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL(String)
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}

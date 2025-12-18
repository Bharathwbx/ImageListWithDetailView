import Foundation

protocol PicsumServiceProtocol {
    func fetchPicsumList() async throws -> [PicsumModel]
}

final class PicsumService: PicsumServiceProtocol {
    
    func fetchPicsumList() async throws -> [PicsumModel] {
        guard let url = URL(string: APIURL.photolist) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([PicsumModel].self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}

//
//  LoginInteractor.swift
//  Benevits
//
//  Created by Fer on 26/03/22.
//

import Foundation


protocol loginDelegate{
    func loginok()
    func loginfail()
}

class LoginInteractor: NSObject, URLSessionDelegate,URLSessionDataDelegate {
    
    
    var delegate : loginDelegate?
    var dataTask : URLSessionDataTask!
    var responseData : Data = Data()
    var httpResponse : HTTPURLResponse!
    
    override init() {
        super.init()
    }
    
    func login(userString :String ,passwordString : String){
        
        let urlString = "https://qa-api.socioinfonavit.com/api/v1/login"
  
    
        
        let parameters = "{\n\"user\": {\n    \"email\":\"\(userString)\",\n    \"password\": \"\(passwordString)\"\n}\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
    
        let sessionConfoguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionConfoguration, delegate: self, delegateQueue:    OperationQueue.main)
        
        dataTask = defaultSession.dataTask(with: request)
        dataTask.resume()
        responseData = Data()
        
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil{
            
            print("xxx\(httpResponse.statusCode)")
            if httpResponse.statusCode == 200{
                
                let response = String(data: responseData, encoding: String.Encoding.utf8)
                if let _ = response{
                    
                    do{
                        let responseLogin = try
                            JSONDecoder().decode(loginResponse.self, from: responseData)
                        
                        print("Respuesta Ok\(responseLogin)")
                        
                        delegate?.loginok()
                        
                    }catch{
                        
                        print("Error creando objetos \(error)")
                        delegate?.loginfail()
                    }
                    
                    
                }else{
                    
                    print("Error en crear string\(error)")
                    delegate?.loginfail()
                }
                
            }else{
                print("http diferente de 200\(error)")
                delegate?.loginfail()
            }
        }else{
            print("El error no fue nil\(error)")
            delegate?.loginfail()
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }
  
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        httpResponse = response as? HTTPURLResponse
        completionHandler(URLSession.ResponseDisposition.allow)
    }
}

struct loginResponse : Codable {
    var id : Int?
    var email : String?
    var role : String?
    var member : Member?
    var signInCount : Int?
    
}

struct Member : Codable {
    var id : Int?
    var userID : Int?
    var idSocioInfonavit : String?
    var name :  String?
    var lastname : String?
    var lastnameMother : String?
    var mobile : JSONNull?
    var zipcode : JSONNull?
    var avatar : String?
    var subscribedToNewsletter : Bool?
    var onlyName : String?
}


class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

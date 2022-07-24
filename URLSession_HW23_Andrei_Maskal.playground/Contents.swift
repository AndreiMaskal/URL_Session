import UIKit
import Foundation

var sessionConfig: URLSessionConfiguration = {
    let configuration = URLSessionConfiguration.default
    configuration.allowsCellularAccess = false
    configuration.waitsForConnectivity = true
    configuration.timeoutIntervalForRequest = 15.0
    configuration.timeoutIntervalForResource = 20.0
    return configuration
}()

let session = URLSession(configuration: sessionConfig)

func getData(url: String?) {
    let url = URL(string: url ?? "вставьте ссылку")
    guard let url = url else { return }
    
    if  !UIApplication.shared.canOpenURL(url) {
        print("ссылка сформирована некорректно")
    }
    
    session.dataTask(with: url) { data, response, error in
        if error != nil && UIApplication.shared.canOpenURL(url)  {
            print("DataTask error:" + "\(String(describing: error?.localizedDescription ?? ""))" + "\n")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Status code: \(response.statusCode)")
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString ?? "")
        }
    }.resume()
}

getData(url: "https://emojihub.herokuapp.com/api/random")


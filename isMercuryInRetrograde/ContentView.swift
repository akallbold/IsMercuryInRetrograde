//
//  ContentView.swift
//  isMercuryInRetrograde
//
//  Created by Anna on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    @State var title: String = "Is mercury in retrograde?"
    @State var answer: String = ""
    @State var manualAnswer: String = "No"
    
    
    var body: some View {
        
        var styles = StyleConfig.determineConfig(from: manualAnswer)
        
        VStack {
            Text(title)
            .padding()

            HStack{
                Text("API: ")
//                    .foregroundColor(styles.primaryColor.opacity(0.5))
                    .foregroundColor(.gray.opacity(0.5))
                Text(answer)
//                    .foregroundColor(styles.primaryColor.opacity(0.5))
                    .foregroundColor(.gray.opacity(0.5))
            }   .padding()
                Button(action: {
                    let newAnswer = manualAnswer == "Yes" ? "No" : "Yes"
                           manualAnswer = newAnswer
                           styles = StyleConfig.determineConfig(from: newAnswer)
                    print(styles)
                       }) {
                           Image("planet")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 100.0, height: 100.0)
                               .padding()
                               .background(
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color.white)
                                       .shadow(color: Color.white.opacity(0.7), radius: 5, x: -5, y: -5)
                                       .shadow(color: Color.gray.opacity(0.7), radius: 5, x: 5, y: 5)
                               )
                           
                            }
            HStack{
                Text("Manual: ")
//                    .foregroundColor(styles.primaryColor.opacity(0.5))
                    .foregroundColor(.gray.opacity(0.5))
                Text(manualAnswer)
//                    .foregroundColor(styles.primaryColor.opacity(0.5))
                    .foregroundColor(.gray.opacity(0.5))
            }.padding()
            
            
        }
        .onAppear() {
            callAPI { response in
                if let response = response {
                    answer = response.is_retrograde ? "Sure fucking is" : "Not today"
                } else {
                    print("Issue getting data")
                }
            }
        }
        .padding()
       
    }
    
    func callAPI(completion: @escaping (IsMercuryInRetogradeResponse?) -> Void) {
        let url = URL(string: "https://mercuryretrogradeapi.com")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return }
            
            do {
                let val = try JSONDecoder().decode(IsMercuryInRetogradeResponse.self, from: data)
                completion(val)
            } catch( _) {
                completion(nil)
            }
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct IsMercuryInRetogradeResponse: Codable {
    var is_retrograde: Bool
}

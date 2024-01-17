import SwiftUI
import Foundation

struct ContentView: View {
    @State private var isLoading = false
    @State private var currentImage = ""
    @State private var song = ""
    @State private var token = "BQDz3oRMpXLoLvjjpvE_fdPI930gkZUDW2KVYA5-HlCVcpWsea4OhrDM2ruuF5TBxKaDlVnhcExMLoZK148vGfC-u8O5OIiOmNfvSQN_hs8Ft48BRly0iRMc7KL4mqJ-af4QjYrnmMOOpUpf6_f3_PyC3jSauBIfOeL8Nr0Vqwxyp1Ne_uWppqumOWmTNZLvNpvgAvTZhJh1LeUYkw81hGcbZu2tLDN5tPDxQY7eYW6lSqmhxUXi2puYmhORXP3gqC-qS_PfAQ85pct_vzuhNgRtO2a0lxfJJOULqVUHrIhKh5AR5A"

    var body: some View {
        
        ZStack{
            Color(.teal)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Button {
                        lightRequest(location: "http://192.168.4.149/api/P7OayCaf4qbguP5TZtXvuhZzJatY6c59VrgJP7AM/groups/5/action", jsonBody: ["on": true])
                        
                    }
                    label: {
                        Image(systemName: "lightbulb.fill").resizable()
                    }
                    .padding(.vertical, 2.0)
                    .disabled(isLoading)
                    
                    Button {
                        lightRequest(location: "http://192.168.4.149/api/P7OayCaf4qbguP5TZtXvuhZzJatY6c59VrgJP7AM/groups/5/action", jsonBody: ["on": false])
                    }
                    label: {
                        Image(systemName: "lightbulb").resizable()
                    }
                    .padding(.vertical, 2.0)
                    .disabled(isLoading)
                
                }.padding()
                .background(Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .shadow(radius: 15)
                )
                HStack{
                    
                    HStack{
                        Button {
                            queueSong()
                        } label: {
                            Circle()
                        }
                        
                        TextField("Song Name", text: $song)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: song) { newValue in
                                song = newValue.replacingOccurrences(of: " ", with: "+")
                            }
                    }
                    .frame(height: 45)
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .shadow(radius: 15)
                    )
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            lightRequest(location: "http://192.168.4.149/api/P7OayCaf4qbguP5TZtXvuhZzJatY6c59VrgJP7AM/groups/5/action", jsonBody: ["xy": [0.64,0.330]])
                        } label: {
                            Circle()
                                .foregroundColor(.red)
                        }
                        Button {
                            lightRequest(location: "http://192.168.4.149/api/P7OayCaf4qbguP5TZtXvuhZzJatY6c59VrgJP7AM/groups/5/action", jsonBody: ["ct": 153])
                        } label: {
                            Circle()
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 90.0)
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .shadow(radius: 15)
                    )
                }
                
                
                VStack(){
                    Button{
                        getCurrentSong()
                    } label: {
                        AsyncImage(url: URL(string: currentImage)) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Image(systemName: "music.mic.circle.fill")
                                .resizable()
                        }
                    }.frame(width: 300, height: 300)
                    
                    HStack {
                        Spacer()
                        Button {
                            rewindTrack()
                        } label: {
                            Image(systemName: "backward")
                        }
                        .disabled(isLoading)
                        Spacer()
                        Button {
                            playTrack()
                        } label: {
                            Image(systemName: "play")
                        }
                        .disabled(isLoading)
                        Spacer()
                        Button {
                            pauseTrack()
                        } label: {
                            Image(systemName: "pause")
                        }
                        .disabled(isLoading)
                        Spacer()
                        Button {
                            skipTrack()
                        } label: {
                            Image(systemName: "forward")
                        }
                        .disabled(isLoading)
                        Spacer()
                    }
                    .padding()
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .background(Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .shadow(radius: 15)
                )
            }.padding()
        }
        
    }
    
    
    
    func pauseTrack() {
        Task{
            await handleRequest(url: "https://api.spotify.com/v1/me/player/pause", method: "PUT")
            getCurrentSong()
            
        }
    }
    
    func playTrack() {
        Task{
            await handleRequest(url: "https://api.spotify.com/v1/me/player/play", method: "PUT")
            getCurrentSong()
        }
    }
    
    func skipTrack() {
        Task{
            await handleRequest(url: "https://api.spotify.com/v1/me/player/next", method: "POST")
            getCurrentSong()
        }
    }
    
    func rewindTrack() {
        Task{
            await handleRequest(url: "https://api.spotify.com/v1/me/player/previous", method: "POST")
            getCurrentSong()
        }
    }
    
    func queueSong() {
        Task{
            var songURI = await getSongURI(songName: song)
            await handleRequest(url:"https://api.spotify.com/v1/me/player/queue?uri=\(songURI)",  method: "POST")
            song = ""
        }
    }
    
    func getCurrentSong() {
        Task {
            guard let json = await handleRequest(url: "https://api.spotify.com/v1/me/player/currently-playing", method: "GET") else{
                print("No response data received")
                currentImage = ""
                return
            }
                if let item = json["item"] as? [String: Any],
                   let album = item["album"] as? [String: Any],
                   let images = album["images"] as? [[String: Any]],
                   let imageURLString = images[1]["url"] as? String {
                    self.currentImage = imageURLString
                } else {
                    print("Image URL not found in response")
                    currentImage = ""
                }
        }
    }
    
    func getSongURI(songName: String) async -> String {
        guard let json = await handleRequest(url: "https://api.spotify.com/v1/search?q=\(songName)&type=track", method: "GET")
        else{
            return ""
        }
        
        // Access the "tracks" dictionary and then the "items" array:
            if let tracks = json["tracks"] as? [String: Any],
               let items = tracks["items"] as? [[String: Any]] {

                // Access the first item in the "items" array and extract its "uri":
                if let firstItem = items.first,
                   let songURI = firstItem["uri"] as? String {
                    return songURI
                } else {
                    print("URI not found in response")
                    return ""
                }
            } else {
                print("Invalid response format")
                return ""
            }
    }
    
    func lightRequest(location: String, jsonBody: Encodable){
        Task{
            guard let url = URL(string: location) else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("Content-Type", forHTTPHeaderField: "application/json")
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(jsonBody)
            request.httpBody = jsonData
            
            do {
                isLoading = true
                let (_, response) = try await URLSession.shared.data(for: request)
                isLoading = false
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response type")
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    print("problem")
                    return
                }
                
                
            } catch {
                print("problem here")
                isLoading = false
                return
            }
        }
    }
    
    

    func handleRequest(url: String, method: String) async -> [String: Any]? {
            guard let urlObject = URL(string: url) else {
                print("Invalid URL")
                return nil
            }
            var request = URLRequest(url: urlObject)
            request.httpMethod = method
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            do {
                isLoading = true
                let (data, response) = try await URLSession.shared.data(for: request)
                isLoading = false

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response type")
                    return nil
                }

                guard httpResponse.statusCode == 200 else {
                    if httpResponse.statusCode == 401 {
                        isLoading = true
                        print("refreshing token")
                        await refreshToken()
                        print("token refreshed retrying request")
                        return await handleRequest(url: url, method: method)
                    } else if httpResponse.statusCode == 204 {
                        return nil
                    } else {
                        print("API error: \(httpResponse.statusCode)")
                        return nil
                    }
                }
                
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                            print("Failed to parse JSON response")
                            return nil
                        }

                        return json

            } catch {
                print("Request error: \(error)")
                return nil
            }
    }
    
    func refreshToken() async {
        guard let urlObject = URL(string: "https://accounts.spotify.com/api/token?grant_type=refresh_token&refresh_token=AQAXY9fYmVIONXtMzdPPnVMYp-ORzAg-xOz6_d5WlruFAIKEFmBfUu9K2eiyCyUE7KZ8AlSakhLDK6ipB9xMxHWwYSejALkLbR2fAkGClxZV1p-eMQJbdizGoONP77mAmMw") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: urlObject)
        request.httpMethod = "POST"
        request.setValue("Basic YTM3MGY4MWY4NjZiNDNhMjg2OWYxMzA4ZmI0NTQ2NjE6MmNkNjA0YTlkN2IzNGIyZTg4YWZmYTdjMzY1N2Y0NmU=", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Failed to parse JSON response")
                return
            }

            if let newToken = json["access_token"] as? String {
                self.token = newToken
            } else {
                print("refresh token failed")
            }

        } catch {
            print("Request error: \(error)")
            return
        }
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

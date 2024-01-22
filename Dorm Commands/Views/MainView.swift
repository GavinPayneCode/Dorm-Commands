import SwiftUI

struct MainView: View {
    @State var loggedIn = false
    @State var selectedTab = 1

    var body: some View {
        VStack {
            if loggedIn {
                TabView(selection: $selectedTab) {
                    
                    LightView()
                        .tabItem {
                            Label("lights", systemImage: "lightbulb")
                        }
                        .tag(0)

                    DashboardView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(1)
                    
                    SpotifyView()
                        .tabItem {
                            Label("music", systemImage: "music.note")
                        }
                        .tag(2)
                }
            } else {
                LogInView(loggedIn: $loggedIn)
            }
        }
    }
}

#Preview {
    MainView()
}

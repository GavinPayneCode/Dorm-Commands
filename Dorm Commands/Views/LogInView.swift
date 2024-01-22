import SwiftUI

struct LogInView: View {
    @Binding var loggedIn: Bool
    
    @State var userName = ""
    @State var passWord = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [ .blue,  .green]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack{
                    VStack{
                        Text("Sign in")
                            .font(.system(size: 60, weight: Font.Weight.heavy, design: Font.Design.rounded))
                        HStack(spacing: 6){
                            Text("New here?")
                            NavigationLink("Sign up", destination: RegisterView())
                        }
                    }.padding(.top,30)
                    Spacer()
                    VStack{
                        VStack{
                            TextField("", text: $userName, prompt: Text("Username").foregroundColor(.black))
                                .padding(.bottom,16)
                                .foregroundStyle(.black)
                            SecureField("", text: $passWord, prompt: Text("Password").foregroundColor(.black))
                                .foregroundStyle(.black)
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(15))
                        .padding()
                        
                        Button(action: {
                            
                            loggedIn = true
                            
                        }, label: {
                            Text("Continue")
                        })
                    }
                    Spacer()
                    
                    VStack{
                        HStack(spacing: 6){
                            Text("Forgot password?")
                            NavigationLink("Reset it", destination: ResetPasswordView())
                        }
                        Image("GlowLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 100, alignment: .bottom)
                    }
                    
                }
            }
        }
    }
}


import SwiftUI

struct ResetPasswordView: View {
    @State var userName = ""
    @State var passWord = ""
    @State var code = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [ .blue,  .red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                
                VStack{
                    VStack{
                        Text("Reset")
                            .font(.system(size: 60, weight: Font.Weight.heavy, design: Font.Design.rounded))
                    }.padding(.top,30)
                    Spacer()
                    VStack{
                        VStack{
                            TextField("", text: $userName, prompt: Text("Username").foregroundColor(.black))
                                .padding(.bottom,16)
                                .foregroundStyle(.black)
                            SecureField("", text: $passWord, prompt: Text("New Password").foregroundColor(.black))
                                .foregroundStyle(.black)
                                .padding(.bottom,16)
                            SecureField("", text: $code, prompt: Text("Admin Code").foregroundColor(.black))
                                .foregroundStyle(.black)
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(15))
                        .padding()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Continue")
                        })
                    }
                    Spacer()
                    
                    VStack{
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


#Preview {
    ResetPasswordView()
}

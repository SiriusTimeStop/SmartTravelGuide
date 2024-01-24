import SwiftUI

struct RideRequestView: View {
    
    // @Binding
    @Binding var searchPlace: String
    @Binding var showSearchResult: Bool
    @Binding var searchBarStatus : Bool
    // State
    @State private var isDragging = false
    @State var selectRideType: RidesType = .luxury
    @StateObject var meterPrice = MapViewModel()
    
    @State var destinationPlace : String = ""
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    //MARK: DATA CORE
    @State private var attraction1 = ""
    @State private var attraction2 = ""
    @State private var attraction3 = ""
    @State private var attraction4 = ""
    @State private var level = ""
    @State private var cost = ""
    
    var body: some View {
        
        VStack{
            //ride type selection view
            HStack{
                Text("SUGGESTED ROUTES")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                    .padding(.top,10)
                Spacer()
                Button{
                    withAnimation(.easeInOut(duration: 4)){
                        showSearchResult.toggle()
                        searchBarStatus.toggle()
                    }
                }label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(Color(.systemGray3))
                        .padding()
                        
                        .background(.white)
                }
                .frame(width: 20, height: 20,alignment: .trailing)
            }
            ScrollView(.horizontal){
                HStack(spacing:10){
                    ForEach(RidesType.allCases){
                        type in
                        VStack(alignment:.center){
                            Image(type.imageName)
                                .resizable()
                               
                                
                            
                            Text(type.description)
                                .font(.system(size: 13,weight: .semibold))
                                .frame(maxWidth: .infinity,alignment:.leading)
                                .padding(.leading,25)
                                .padding(.bottom,5)
                                .foregroundColor(.black)
                            
                            HStack{
                               Image(systemName: "mappin.and.ellipse")
                                    .frame(width: 5, height: 12)
                                    .foregroundColor(.black)
                                    .font(.system(size: 13,weight: .semibold))
                                Text("Hong kong")
                                    .foregroundColor(.gray)
                                    .padding(.leading,1)
                                    .font(.system(size: 13,weight: .semibold))
                            }
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.leading,30)
                            .padding(.bottom,5)
                            Text("$\(type.routePrice)")
                                .font(.system(size: 13,weight: .semibold))
                                .padding(.bottom,28)
                                .frame(maxWidth: .infinity,alignment:.leading)
                                .padding(.leading,25)
                            
                        }
                        .frame(width: 180,height: 250)
                        .foregroundColor(type == selectRideType ? Color.init(hex: "#57BFD2",alpha: 1.0) : .black)
                        .background(Color(.systemGroupedBackground))
                        .scaleEffect(type == selectRideType ? 1.2 : 1.0)
                        .cornerRadius(20)
                        .onTapGesture {
                            withAnimation (.spring()) {
                                selectRideType = type
                                if selectRideType == .luxury{
                                    destinationPlace = "Victoria Peak"
                                    
                                }else if selectRideType == .normal{
                                    destinationPlace = "Avenue of Stars"
                                   
                                }else if selectRideType == .poor{
                                    destinationPlace = "Avenue of Stars"
                                    
                                }else{
                                    destinationPlace = "Not in area"
                                }
                            }
                        }
                    }
                }
                .environmentObject(meterPrice)
            }
            .padding(.horizontal)
            .padding(.top,2)
            .padding(.bottom,30)

            //request ride button
            Button {
                if selectRideType == .luxury{
                    DataController().addAttraction(level: "Luxury", attraction1: "Ngong Ping 360", attraction2: "Tian Tan Buddha", attraction3: "Hong Kong Disneyland", attraction4: "Victoria Peak", cost: "2700.0", context: managedObjContext)
                    dismiss()
                }else if selectRideType == .normal{
                    DataController().addAttraction(level: "Normal", attraction1: "Tian Tan Buddha", attraction2: "Ocean Park", attraction3: "Star Ferry", attraction4: "Avenue Of The Stars",cost: "1000.0", context: managedObjContext)
                    dismiss()
                }else if selectRideType == .poor{
                    DataController().addAttraction(level: "Poor", attraction1: "Hong Kong Park", attraction2: "Star Ferry", attraction3: "Hong Kong Museum Of History", attraction4: "Avenue Of The Stars",cost: "600.0", context: managedObjContext)
                    dismiss()
                }
                
            } label: {
                Text("CONFIRM ROUTES")
                    .fontWeight(.bold)
                    .frame(width: 289,height: 50)
                    .background(Color.init(hex: "#57BFD2",alpha: 1.0))
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
            .padding(.bottom,10)
        }
        .padding(.bottom,25)
        .padding(.horizontal,5)
        .background(.white)
        .cornerRadius(20)
    }
}

struct RideRequestView_Previews: PreviewProvider{
    
    @State static var searchPlace: String = ""
    @State static var destinationPlace: String = ""
    
    static var previews: some View{
        RideRequestView(searchPlace: $searchPlace,showSearchResult: .constant(true),searchBarStatus:.constant(true))
    }
}

#include <iostream>

using namespace std;
void WinterCropManagement(int wheat,int peas,int potatoes){
        for(int i = 0; i<wheat; i++)
        {
            cout << "*";
        }
        cout << endl;
        for(int i = 0; i<peas; i++)
        {
            cout << "%";
        }
        cout << endl;
        for(int i = 0; i<potatoes; i++)
        {
            cout << "@";
        }
        cout << endl;
        cout << "The Planted crops are scheduled to be harvested between January and March" << endl;
    }
void Summercropmanagement(int wheat, int peas, int potatoes, int maize,int beans,int pumpkin,int sorghum,int watermelon,int groundnut){
        for(int i = 0; i<wheat; i++)
        {
            cout << "*";
        }
        cout << endl;
        for(int i = 0; i<maize; i++)
        {
            cout << "!";
        }
        cout << endl;
        for(int i = 0; i<beans; i++)
        {
            cout << "#";
        }
        cout << endl;
        for(int i = 0; i<peas; i++)
        {
            cout << "%";
        }
        cout << endl;
        for(int i = 0; i<pumpkin; i++)
        {
            cout << "$";
        }
        cout << endl;
        for(int i = 0; i<sorghum; i++)
        {
            cout << "^";
        }
        cout << endl;
        for(int i = 0; i<potatoes; i++)
        {
            cout << "@";
        }
        cout << endl;
        for(int i = 0; i<watermelon; i++)
        {
            cout << "w";
        }
        cout << endl;
        for(int i = 0; i<groundnut; i++)
        {
            cout << "G";
        }
        cout << endl;
        cout << "The Planted crops are scheduled to be harvested between November and December" << endl;
    }
int soil_prep_condition(){
    // Initial soil fertility factor
    int soil_fert;
	cout<<"Enter the soil fertility factor read by The soil NPK sensor:"<<endl;
	//The reading is between 1 and 10. If the reading exceeds 10 the soil quality factor decreases
	cin>>soil_fert;
    // Test soil fertility
    if (soil_fert<5 || soil_fert>10)
	{
        cout << "Soil fertility is low." << endl;
    }
	else if (soil_fert==5)
	{
        cout << "Soil fertility is moderate." << endl;
    }
	else
	{
        cout << "Soil fertility is high." << endl;
    }
    int soil_moist;
    cout<<"\nEnter level of soil moisture between 1 and 10: \n";
    cin>>soil_moist;
    if (soil_moist<5)
    {
        cout<<"Soil moisture is low\n";
    }
    else
    {
        cout<<"Soil moisture is adequate\n";
    }
    int soil_qual = (soil_fert+soil_moist)/2;
    cout<<"The soil quality of the plot is: "<<soil_qual<<endl;
    return soil_qual;
}
int yield_calc(int wheat,int peas,int potatoes,int maize,int beans,int pumpkin,int sorghum,int watermelon,int groundnut,int total_crops,int soil_condition) {

     int total_yield;
     int yield_wheat;
     int yield_peas;
     int yield_potatoes;
     int yield_maize;
     int yield_beans;
     int yield_pumpkin;
     int yield_sorghum;
     int yield_watermelon;
     int yield_groundnut;

     yield_wheat=wheat*soil_condition;
     yield_peas=peas*soil_condition;
     yield_potatoes=potatoes*soil_condition;
     yield_maize=maize*soil_condition;
     yield_beans=beans*soil_condition;
     yield_pumpkin=pumpkin*soil_condition;
     yield_sorghum=sorghum*soil_condition;
     yield_watermelon=watermelon*soil_condition;
     yield_groundnut=groundnut*soil_condition;
     total_yield = total_crops*soil_condition;

     cout<<"\nThe total yield is:  "<<total_yield<<endl;
     cout<<"The yield for wheat is: "<<yield_wheat<<endl;
     cout<<"The yield for peas is: "<<yield_peas<<endl;
     cout<<"The yield for potatoes is: "<<yield_potatoes<<endl;
     cout<<"The yield for maize is: "<<yield_maize<<endl;
     cout<<"The yield for beans is: "<<yield_beans<<endl;
     cout<<"The yield for pumpkin is: "<<yield_pumpkin<<endl;
     cout<<"The yield for sorghum is: "<<yield_sorghum<<endl;
     cout<<"The yield for watermelon is: "<<yield_watermelon<<endl;
     cout<<"The yield for groundnut is: "<<yield_groundnut<<endl<<endl;
     return total_yield;
 }
void Summerharvest(int wheat,int peas,int potatoes){
    for(int i = 0; i<wheat; i++)
            {
                cout << "*";
            }
            cout << endl;
            for(int i = 0; i<peas; i++)
            {
                cout << "%";
            }
            cout << endl;
            for(int i = 0; i<potatoes; i++)
            {
                cout << "@";
            }
            cout << endl;
}

void Winterharvest(){
cout<<"Harvested! Field is empty"<<endl;
}
int main()
{
    int soil_condition;
    int wheat, peas, potatoes, maize, beans, pumpkin, sorghum, watermelon, groundnut;
    int option;
    cout<<"Machobane Farming Simulation\n"<<endl;
    //The assumption is that the simulation runs an annual cycle ; you cannot select for example January after selecting February
    cout<<"Select option from the menu\n"<<endl;
    do{
        cout<<"For planting and harvesting select which season you want to access"<<endl;

        cout<<"1. Prepare soil"<<endl;
        cout<<"2. Winter Crop Management"<<endl;
        cout<<"3. Summer Crop Management"<<endl;
        cout<<"4. Calculate Yield"<<endl;
        cout<<"5. Quit"<<endl;
        cin>>option;
        switch(option){
        case 3:
            int select;
            cout<<"Select 1. to plant and 2. to harvest"<<endl;
            cin>>select;
            if (select==1){
            cout << "Planting maize, beans, pumpkin, sorghum ,watermelons and groundnuts " << endl;
            cout << "How many 1. maize seeds, 2. bean seeds, 3. pumpkin,\n4. Sorghum seeds, 5. Watermelon seeds and\n6. Groundnut seeds do you want to plant?" << endl;
            cout << "Maize: " <<endl;
            cin >> maize;
            cout << "Beans: " <<endl;
            cin >> beans;
            cout << "Pumpkin: " <<endl;
            cin >> pumpkin;
            cout << "Sorghum: " <<endl;
            cin >> sorghum;
            cout << "Watermelon: " <<endl;
            cin >> watermelon;
            cout << "Groundnuts: " <<endl;
            cin >> groundnut;
                Summercropmanagement(wheat, peas, potatoes, maize, beans, pumpkin, sorghum, watermelon, groundnut);
            }
            else
            //Assumption is that you can only harvest if you have planted
            Summerharvest(wheat, peas, potatoes);
                        break;
        case 2:
            cout<<"Select 1. to plant and 2. to harvest"<<endl;
            cin>>select;
            if (select==1){
            cout << "Planting wheat, peas and potatoes" << endl;
            cout << "How many 1. wheat seeds, 2. pea seeds and 3. potato seeds do you want to plant?" << endl;
            cout << "Wheat: " <<endl;
            cin >> wheat;
            cout << "Peas: " <<endl;
            cin >> peas;
            cout << "Potatoes: " <<endl;
            cin >> potatoes;
            WinterCropManagement(wheat, peas, potatoes);
            }
            else
            //Assumption is that you can only harvest if you have planted
            Winterharvest();
            break;
        case 1:
            soil_condition=soil_prep_condition();
            break;
        case 4:
            int total_seeds_sowed;
            total_seeds_sowed=wheat+peas+potatoes+maize+beans+pumpkin+sorghum+watermelon+groundnut;
            cout<<total_seeds_sowed;
            yield_calc(wheat, peas, potatoes, maize, beans, pumpkin, sorghum, watermelon, groundnut, total_seeds_sowed, soil_condition);
            break;
        }
    }while(option!=5);
    return 0;
}

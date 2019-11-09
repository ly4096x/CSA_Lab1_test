#include <iostream>
#include <bitset>
#include <string>
#include <fstream>
using namespace std;

int main(int argc, char *argv[]) {
    int x, valCounter = 0;
    ofstream f("dmem.txt");
    bool firstOut = true;
    cout << "Enter dmem values:" << endl;
    while (cin >> x) {
        ++valCounter;
        const auto s = bitset<32>(x).to_string();
        for (auto i = 0; i != 4; ++i) {
            if (!firstOut || i != 0) {
                f << "\n";
                firstOut = false;
            }
            f << s.substr(i * 8, 8);
        }
    }
    f.close();
    cout << "Wrote " << (valCounter * 4) << " bytes" << endl;
    return 0;
}

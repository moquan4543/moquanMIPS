#include <iostream>
#include <fstream>
#include <vector>
#include <iomanip>

int main() {
    std::ifstream file("../../inst_rom.bin", std::ios::binary | std::ios::ate);
    if (!file.is_open()) {
        std::cerr << "Failed to open file" << std::endl;
        return 1;
    }

    //get file size
    std::streamsize size = file.tellg();
    file.seekg(0, std::ios::beg);

    //read file content to buffer
    std::vector<char> buffer(size);
    if (!file.read(buffer.data(), size)) {
        std::cerr << "Failed to read file" << std::endl;
        return 1;
    }

    std::ofstream outputFile("../../inst_rom.data");

    //write each word with hex to the file
    int count = 0;
    for (const auto& byte : buffer) {
        outputFile << std::hex << std::setw(2) << std::setfill('0') << (static_cast<int>(static_cast<unsigned char>(byte)));
        ++count;
        if(count && count % 4 == 0){
            outputFile << '\n';
        }
    }
    std::cout << "done!\n";
    return 0;
}
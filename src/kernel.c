//显示文字内容
void print(char* msg, int color) {
    char* video = (char*)0xB8000;
    for(int i = 0; msg[i] != '\0'; i++) {
        video[i * 2] = msg[i];
        video[i * 2 + 1] = color;
    }
}

void kernel_main() {
    print("hello MintOS", 0x07);
    while (1) {

    }
}
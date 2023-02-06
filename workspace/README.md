# Steps to Run the code:
1. First mount the DOSBOX drive to the current directory. This can be done by running the following command in the DOSBOX terminal:
```bash
mount c $(pwd) # $(pwd) is the current directory
```

2. Then change the directory to the current directory by running the following command:
```bash
c:
```
3. Then run the following command to `assemble` the code:
```bash
nasm hello.asm -o hello.com -l hello.lst
```
4. Finally run the following command to run the code:
```bash
hello.com
```
5. *(Optional)* You can debug the code `line by line` by running the following command:
```bash
afd hello.com
```
# Output:
- **Hello World!** is printed on the screen. 😀

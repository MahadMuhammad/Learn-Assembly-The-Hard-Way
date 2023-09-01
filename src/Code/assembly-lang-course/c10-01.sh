
# ----------------------------
#  Cross-Compilation Tutorial 
# ----------------------------


- Write the code 
  cd /tmp 
  mkdir risc 
  vi HelloWorld.s 

# --------------- start of program  
# Source: https://smist08.wordpress.com/2019/09/07/risc-v-assembly-language-hello-world/

# Risc-V Assembler program to print "Hello World!"
# to stdout.
#
# a0-a2 - parameters to linux function services
# a7 - linux function number
#

.global _start      # Provide program starting address to linker

# Setup the parameters to print hello world
# and then call Linux to do it.

_start: addi  a0, x0, 1      # 1 = StdOut
        la    a1, helloworld # load address of helloworld
        addi  a2, x0, 13     # length of our string
        addi  a7, x0, 64     # linux write system call
        ecall                # Call linux to output the string

# Setup the parameters to exit the program
# and then call Linux to do it.

        addi    a0, x0, 0   # Use 0 return code
        addi    a7, x0, 93  # Service command code 93 terminates
        ecall               # Call linux to terminate the program

.data
helloworld:      .ascii "Hello World!\n"
# --------------- end of program 



- Cross-Compile for RISCV 
- Download GNU cross-compilation tools (https://wiki.debian.org/RISC-V#Cross_compilation) 
  
  sudo dpkg --add-architecture riscv64 
  sudo apt-get install gcc-riscv64-linux-gnu g++-riscv64-linux-gnu 
  sudo sh -c "cat >/etc/ld.so.conf.d/riscv64-linux-gnu.conf <<EOF
/usr/local/lib/riscv64-linux-gnu
/lib/riscv64-linux-gnu
/usr/lib/riscv64-linux-gnu
/usr/riscv64-linux-gnu/lib/
EOF
"
  
  sudo ln -s /usr/riscv64-linux-gnu/lib/ld-linux-riscv64-lp64d.so.1 /lib

- Cross Compile: 
  riscv64-linux-gnu-as -march=rv64imac -o HelloWorld.o HelloWorld.s
  riscv64-linux-gnu-ld -o HelloWorld HelloWorld.o

- See the assembly: 
  riscv64-linux-gnu-objdump -d HelloWorld


- Download Tiny Emulator source and disk image. (https://bellard.org/tinyemu/) 

- Build and install tiny emulator 

  cd Downloads 
  tar zxvf tinyemu-2019-12-21.tar.gz
  tinyemu-2019-12-21 
  sudo apt install libssl-dev libsdl-dev libcurl4-openssl-dev vim 
  make   # make scripts are important to learn 
  sudo make install 

- cd Downloads/

- tar zxvf diskimage-linux-riscv-2018-09-23.tar.gz 
  cd diskimage-linux-riscv-2018-09-23
  cat root_9p-riscv64.cfg 
  # copy the fs0 line 
  vi root-riscv64.cfg
  # paste the line after drive0 line 

- temu root-riscv64.cfg 
- mount -t 9p /dev/root /mnt 
- cd /mnt 
- cd risc 
- ./HelloWorld 


# More explanation here: https://smist08.wordpress.com/2019/09/07/risc-v-assembly-language-hello-world/

#!/bin/bash
output() {
        printf "\E[0;33;40m"
        echo $1
        printf "\E[0m"
}
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git screen
output "";
cd
rm -rf cpuminer-opt
git clone https://github.com/JayDDee/cpuminer-opt
cd cpuminer-opt
./build.sh
cp cpuminer ../
output "";
output "Create bash file"
cd /root/cpuminer-opt
echo "" > auto.sh
echo "#!/bin/bash" >> auto.sh
echo "cd /root/cpuminer-opt" >> auto.sh
echo "./cpuminer -a lyra2z330 -o stratum+tcp://hxx-pool1.chainsilo.com:3032 -u minhthang.90 -p x" >> auto.sh
chmod 0777 auto.sh
output "Add cronjob"
crontab -l > mycron
echo "@reboot /root/cpuminer-opt/auto.sh" >> mycron
crontab mycron
rm mycron
sudo reboot now

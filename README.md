# vivado-docker

Vivado installed into a docker image for CI purposes.

## Build instructions
1. Download Vivado full tar.gz from Xilinx website
2. Change the IP in ```install.sh``` to your local IP
3. Run a web server in the Vivado download directory
```bash
cd /path/to/Vivado/download
python -m http.server 8000
```
4. Change the Vivado installation settings in ```install_config.txt```
5. In a new shell, run the install script
```bash
chmod +x install.sh
sudo ./install.sh
```

# vivado-docker

Vivado installed into a docker image for CI purposes.

## Build instructions
1. Download Vivado full tar.gz from Xilinx website
2. Change the IP in ```install.sh``` to your local IP
3. Run a web server in the Vivado download directory
```bash
cd /path/to/Vivado/download
python3.7 -m http.server 8000
```
4. Change the Vivado installation settings in ```install_config.txt```
5. In a new shell, run the install script
```bash
chmod +x install.sh
sudo ./install.sh
```

## Debug
If installation failed search for untagged image in
```bash
docker images
```

and run 
```bash
docker run -ti <IMAGE_ID>
```

## X11 for Mac OSX
### Setup

1. Install [XQuartz](https://www.xquartz.org/)
2. Activate the option ‘Allow connections from network clients’ in XQuartz settings
3. reboot

### Run
```bash
# Allow access
xhost + 127.0.0.1

# Run
docker run -e DISPLAY=docker.for.mac.localhost:0 -ti docker-vivado:2018.2

# Within container, run vivado
vivado
```
![](https://i.imgur.com/Z8HMGwl.png)


# 🐧 Docker T6Server Setup for Plutonium (Manual Launch Style)

This guide provides an easy way to run [Sterbweise's T6Server installer](https://github.com/Sterbweise/T6Server) inside a clean Debian-based Docker container.


---

## 🛠️ Clone the Repo and Build the Docker Image

First, clone this repo:

```bash
git clone https://github.com/briannicholls/debian-image-for-t6-server.git
cd debian-image-for-t6-server
```

Build the Docker image:

```bash
docker build -t t6server .
```

---

## 🧱 One-time: Create the container:

```bash
docker run -it --name my-t6server \
  --network host \
  --cap-add=SYS_ADMIN --privileged \
  -v "/home/bfive/t6server/plutonium/Call of Duty Black Ops II":/opt/T6Server/Game \
  t6server
```

---

## ▶️ Start the container

```bash
docker start -ai my-t6server
```

---

## That's it!

Now you have a clean Debian environment to run [Sterbweise's T6Server installer](https://github.com/Sterbweise/T6Server)
I've included some installation docs below.

## 📦 Inside the container: Run Sterbweise’s T6Server Installer

```bash
cd /opt/T6Server
sudo ./install.sh
```

Then configure your server:

```bash
cd /opt/T6Server/Plutonium
nano T6Server.sh
```

Update:
- `SERVER_NAME` (display name in server browser)
- `SERVER_KEY` (from your Plutonium account)

All other defaults are already correct for this Docker image. `dedicated.cfg` will be created automatically.

---

## 🚀 Launch the server manually

```bash
cd /opt/T6Server/Plutonium
./T6Server.sh
```

If your ports are forwarded, you should see your server pop up in Plutonium's server list. It may take some time, for me it was about five minutes the first time.

---


## 🔁 Committed image and persistence

All changes made inside the container will persist as long as you:
- Continue using `docker start -ai my-t6server`
- Mount your game files from the host (as shown above)

You do **not** need to commit new images unless you want to back up or duplicate your setup.

If you want to snapshot your current state:

```bash
docker commit my-t6server t6server-backup
```

Then later:

```bash
docker run -it --name my-t6server-restore \
  --network host \
  --cap-add=SYS_ADMIN --privileged \
  -v "/home/bfive/t6server/plutonium/Call of Duty Black Ops II":/opt/T6Server/Game \
  t6server-backup
```

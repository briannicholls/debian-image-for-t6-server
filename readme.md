# 🐧 Docker T6Server Setup for Plutonium (Manual Launch Style)

This guide provides an easy way to run [Sterbweise's T6Server installer](https://github.com/Sterbweise/T6Server) inside a clean Debian-based Docker container.

---

## 🛠️ Build the Docker Image

This setup uses a custom Docker image built from two files in this repo:

- `Dockerfile` – defines the Debian environment and installs Wine + dependencies
- `entrypoint.sh` – sets up the container environment on boot

From the root of the repo, build the image:

```bash
docker build -t t6server .
```

> 📝 Make sure both `Dockerfile` and `entrypoint.sh` are in the same directory when you run this command.

---

## 🧱 One-time: Create the container
Run this if you're starting from scratch:

```bash
docker run -it --name my-t6server \
  --network host \
  --cap-add=SYS_ADMIN --privileged \
  -v "/home/bfive/t6server/plutonium/Call of Duty Black Ops II":/opt/T6Server/Game \
  t6server
```

> ✅ `--network host` is required so the server appears on Plutonium’s master list.
> ✅ Forward UDP port 4976 from your router to your Docker host.

---

## ▶️ Start the container

```bash
docker start -ai my-t6server
```

---

## 📦 Inside the container: Run Sterbweise’s T6Server Installer

These steps are for installing T6Server from scratch inside the container. Only needed the first time.

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

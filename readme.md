# 🛠️ Docker T6Server Setup for Plutonium (Manual Launch Style)

## ✅ One-time: Create the container from your working image
**Only run this if you're starting fresh.**

```bash
docker run -it --name my-t6server \
  --network host \
  --cap-add=SYS_ADMIN --privileged \
  -v "/home/bfive/t6server/plutonium/Call of Duty Black Ops II":/opt/T6Server/Game \
  t6server-working
```

---

## 🔄 Start the container (once created)

```bash
docker start -ai my-t6server
```

---

## 🧭 Inside the container

### 🧱 One-time setup (if needed)

```bash
cd /opt/T6Server
sudo ./install.sh
```

### ⚙️ Configure the server

```bash
cd /opt/T6Server/Plutonium
nano T6Server.sh
```

Edit the following lines:

```bash
readonly SERVER_NAME="My Server Name"
readonly GAME_PATH="/opt/T6Server/Game"
readonly SERVER_KEY="your_key_here"
readonly SERVER_PORT=4976
readonly CONFIG_FILE="dedicated.cfg"
```

Make sure `/opt/T6Server/Game/dedicated.cfg` exists and is valid.

---

## 🚀 To launch the server manually

```bash
cd /opt/T6Server/Plutonium
./T6Server.sh
```

---

## 💾 To restore from a committed image later (if needed)

```bash
docker run -it --name my-t6server-restored \
  --network host \
  --cap-add=SYS_ADMIN --privileged \
  -v "/home/bfive/t6server/plutonium/Call of Duty Black Ops II":/opt/T6Server/Game \
  t6server-working

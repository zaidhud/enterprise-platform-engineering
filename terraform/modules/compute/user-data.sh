#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y python3

mkdir -p /opt/document-service

cat > /opt/document-service/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Enterprise Platform</title>
</head>
<body>
  <h1>Document Service</h1>
  <p>The application is running inside the private application subnet.</p>
</body>
</html>
EOF

cat > /etc/systemd/system/document-service.service <<'EOF'
[Unit]
Description=Document Service Demo
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/document-service
ExecStart=/usr/bin/python3 -m http.server 8080
Restart=always
User=nobody

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable document-service
systemctl start document-service
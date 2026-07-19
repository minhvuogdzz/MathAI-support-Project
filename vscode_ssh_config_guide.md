# VS Code Remote SSH - Hướng dẫn Kết nối tới Kaggle GPU

## 1. Cài đặt Extension
- Mở VS Code → Extensions (Ctrl+Shift+X)
- Tìm và cài: **Remote - SSH** (by Microsoft)

## 2. Cấu hình SSH Config

Mở file `~/.ssh/config` và thêm entry sau:

```
Host kaggle-cavat
    HostName <NGROK_HOST>
    Port <NGROK_PORT>
    User root
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

> ⚠️ Thay `<NGROK_HOST>` và `<NGROK_PORT>` bằng giá trị hiển thị ở **Cell 3** của notebook Kaggle.

## 3. Kết nối

### Cách 1: Command Palette
1. `Ctrl+Shift+P` (hoặc `Cmd+Shift+P` trên macOS)
2. Gõ: `Remote-SSH: Connect to Host...`
3. Chọn: `kaggle-cavat`
4. Nhập mật khẩu: `cavat123`

### Cách 2: Terminal
```bash
ssh root@<NGROK_HOST> -p <NGROK_PORT>
# Password: cavat123
```

## 4. Mở thư mục Project
Sau khi kết nối thành công:
1. File → Open Folder
2. Navigate tới: `/kaggle/working/CAVAT_PROJECT`
3. Click OK

## 5. Extensions cần thiết trên Remote

Sau khi kết nối, cài thêm các extensions trên remote server:
- **Python** (by Microsoft)
- **Jupyter** (by Microsoft)  
- **GitLens** (by GitKraken)

## 6. Lưu ý quan trọng

| Hạng mục | Chi tiết |
|----------|----------|
| **Session timeout** | Kaggle GPU session tối đa ~12 giờ |
| **Mất kết nối** | Chạy lại Cell 3 trên Kaggle, cập nhật SSH config |
| **Lưu code** | Luôn gọi `save_now()` trong notebook trước khi đóng |
| **GPU monitoring** | Terminal trên VS Code: `watch -n 1 nvidia-smi` |
| **Working dir** | Chỉ `/kaggle/working/` được giữ lại giữa các cell |

## 7. Troubleshooting

### SSH bị từ chối kết nối
```bash
# Trên notebook Kaggle, chạy:
!service ssh status
!service ssh start
```

### Ngrok tunnel mất kết nối
```
# Chạy lại Cell 3 trên notebook Kaggle
# Cập nhật host/port mới trong ~/.ssh/config
```

### VS Code báo "Could not establish connection"
1. Kiểm tra Ngrok tunnel còn hoạt động (Cell 4 watchdog)
2. Xóa known_hosts cũ: `ssh-keygen -R <NGROK_HOST>`
3. Thử kết nối lại

### Không thấy GPU trong VS Code terminal
```bash
nvidia-smi  # Phải hiển thị GPU T4
python -c "import torch; print(torch.cuda.is_available())"  # Phải là True
```

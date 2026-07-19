#!/bin/bash
# ============================================
# CAVAT Remote Dev - Quick Reference Script
# ============================================
# Dự án: CAVAT - AI Trợ giảng Toán học
# Mục đích: Tham chiếu nhanh các lệnh thường dùng
# ============================================

# Màu sắc
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

show_help() {
    echo -e "${CYAN}============================================${NC}"
    echo -e "${CYAN}  🚀 CAVAT Remote Dev - Quick Reference${NC}"
    echo -e "${CYAN}============================================${NC}"
    echo ""
    echo -e "${GREEN}Sử dụng:${NC}"
    echo "  ./cavat_remote_quickstart.sh <command>"
    echo ""
    echo -e "${YELLOW}Commands:${NC}"
    echo -e "  ${BLUE}connect${NC}     - Kết nối SSH tới Kaggle"
    echo -e "  ${BLUE}status${NC}      - Kiểm tra trạng thái kết nối"
    echo -e "  ${BLUE}gpu${NC}         - Xem thông tin GPU"
    echo -e "  ${BLUE}save${NC}        - Lưu code lên GitHub"
    echo -e "  ${BLUE}setup${NC}       - Hiển thị hướng dẫn setup"
    echo -e "  ${BLUE}help${NC}        - Hiển thị trợ giúp này"
    echo ""
}

cmd_connect() {
    echo -e "${CYAN}🔗 Kết nối tới Kaggle GPU...${NC}"
    echo ""
    
    # Đọc config từ SSH config nếu có
    if grep -q "kaggle-cavat" ~/.ssh/config 2>/dev/null; then
        echo -e "${GREEN}Tìm thấy config 'kaggle-cavat' trong ~/.ssh/config${NC}"
        echo -e "Đang kết nối..."
        ssh kaggle-cavat
    else
        echo -e "${YELLOW}Chưa có config SSH.${NC}"
        echo ""
        echo "Thêm vào ~/.ssh/config:"
        echo ""
        echo "  Host kaggle-cavat"
        echo "      HostName <NGROK_HOST>"
        echo "      Port <NGROK_PORT>"
        echo "      User root"
        echo "      StrictHostKeyChecking no"
        echo "      UserKnownHostsFile /dev/null"
        echo ""
        echo -e "Hoặc kết nối trực tiếp:"
        echo -e "  ${GREEN}ssh root@<NGROK_HOST> -p <NGROK_PORT>${NC}"
        echo -e "  Password: ${YELLOW}cavat123${NC}"
    fi
}

cmd_status() {
    echo -e "${CYAN}📊 Kiểm tra trạng thái...${NC}"
    echo ""
    
    if grep -q "kaggle-cavat" ~/.ssh/config 2>/dev/null; then
        HOST=$(grep -A3 "kaggle-cavat" ~/.ssh/config | grep "HostName" | awk '{print $2}')
        PORT=$(grep -A3 "kaggle-cavat" ~/.ssh/config | grep "Port" | awk '{print $2}')
        
        echo -e "Host: ${GREEN}$HOST${NC}"
        echo -e "Port: ${GREEN}$PORT${NC}"
        echo ""
        
        # Test connection
        echo "Testing SSH connection..."
        if ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no kaggle-cavat "echo 'OK'" 2>/dev/null; then
            echo -e "${GREEN}✅ Kết nối thành công!${NC}"
        else
            echo -e "${RED}❌ Không thể kết nối. Kiểm tra:${NC}"
            echo "  1. Kaggle notebook có đang chạy?"
            echo "  2. Ngrok tunnel có còn hoạt động?"
            echo "  3. Host/Port có đúng không?"
        fi
    else
        echo -e "${YELLOW}Chưa cấu hình SSH. Chạy: ./cavat_remote_quickstart.sh setup${NC}"
    fi
}

cmd_gpu() {
    echo -e "${CYAN}🖥️  Thông tin GPU (remote)...${NC}"
    echo ""
    ssh kaggle-cavat "nvidia-smi" 2>/dev/null || echo -e "${RED}❌ Không thể kết nối tới remote${NC}"
}

cmd_save() {
    echo -e "${CYAN}💾 Lưu code lên GitHub...${NC}"
    echo ""
    
    PROJECT_DIR="/kaggle/working/CAVAT_PROJECT"
    ssh kaggle-cavat "cd $PROJECT_DIR && git add -A && git commit -m 'Quick save $(date +%Y-%m-%d_%H:%M)' && git push origin main" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Đã lưu thành công!${NC}"
    else
        echo -e "${RED}❌ Lưu thất bại. Thử chạy save_now() trong notebook Kaggle.${NC}"
    fi
}

cmd_setup() {
    echo -e "${CYAN}============================================${NC}"
    echo -e "${CYAN}  📋 HƯỚNG DẪN SETUP NHANH${NC}"
    echo -e "${CYAN}============================================${NC}"
    echo ""
    echo -e "${YELLOW}Bước 1:${NC} Mở notebook 'kaggle_remote_dev_setup.ipynb' trên Kaggle"
    echo -e "${YELLOW}Bước 2:${NC} Bật GPU T4 và Internet trong Settings"
    echo -e "${YELLOW}Bước 3:${NC} Chạy tuần tự Cell 1 → Cell 6"
    echo -e "${YELLOW}Bước 4:${NC} Copy SSH endpoint từ Cell 3"
    echo -e "${YELLOW}Bước 5:${NC} Cập nhật ~/.ssh/config với host/port mới"
    echo -e "${YELLOW}Bước 6:${NC} VS Code → Remote-SSH → Connect to kaggle-cavat"
    echo ""
    echo -e "${GREEN}Password SSH: cavat123${NC}"
    echo ""
    echo -e "📖 Chi tiết: xem file ${BLUE}vscode_ssh_config_guide.md${NC}"
}

# Main
case "${1:-help}" in
    connect) cmd_connect ;;
    status)  cmd_status ;;
    gpu)     cmd_gpu ;;
    save)    cmd_save ;;
    setup)   cmd_setup ;;
    help)    show_help ;;
    *)       echo -e "${RED}Lệnh không hợp lệ: $1${NC}"; show_help ;;
esac

# CAVAT - AI Trợ giảng Toán học | MathAI Support Project

## 📋 Tổng quan

**CAVAT** là hệ thống AI trợ giảng Toán học tích hợp vào nền tảng Moodle, được xây dựng với triết lý **Socratic Method** - hướng dẫn học sinh tư duy thay vì đưa đáp án trực tiếp.

### 🎯 Đặc điểm nổi bật
- **Qwen 2.5 - 1.5B** fine-tuned bằng **QLoRA** cho phần cứng giới hạn
- **Custom RAG** với FAISS - chunking bằng Regex bảo toàn cấu trúc công thức Toán
- **Kiến trúc Microservices**: ReactJS Frontend (Vite + Yarn) + FastAPI Backend
- **Phương pháp Socratic**: Gợi ý từng bước, không đưa đáp án trực tiếp
- **Multimodal**: Hỗ trợ upload ảnh đề bài viết tay (Qwen2-VL / OCR)
- **Agentic Workflow**: Code Interpreter với SymPy cho tính toán chính xác 100%

## 🏗️ Kiến trúc

```
┌─────────────────────────────────────────────────────┐
│                    Frontend                         │
│    ReactJS (Vite + Yarn) / Moodle Plugin Widget     │
│              ↕ API (Token Auth)                     │
├─────────────────────────────────────────────────────┤
│                    Backend                          │
│    FastAPI + Docker (Containerized)                 │
│    ┌───────────────┬──────────────────────────┐     │
│    │  Qwen 2.5     │   Custom RAG (FAISS)     │     │
│    │  QLoRA 4-bit  │   Regex Chunking         │     │
│    │  Fine-tuned   │   SGK Math Knowledge     │     │
│    └───────────────┴──────────────────────────┘     │
│    ┌───────────────┬──────────────────────────┐     │
│    │  Vision Model │   Code Interpreter       │     │
│    │  Qwen2-VL/OCR │   SymPy Sandbox         │     │
│    └───────────────┴──────────────────────────┘     │
└─────────────────────────────────────────────────────┘
```

## 🚀 Phát triển từ xa (Remote Dev trên Kaggle GPU)

Dự án sử dụng **Kaggle GPU T4** cho việc training và inference. Kết nối qua SSH Tunnel (Ngrok).

### Bắt đầu nhanh
1. Upload `kaggle_remote_dev_setup.ipynb` lên Kaggle
2. Bật GPU T4 + Internet
3. Chạy tuần tự các cell
4. Kết nối VS Code qua Remote SSH

📖 Xem chi tiết: [vscode_ssh_config_guide.md](./vscode_ssh_config_guide.md)

### Lệnh tham chiếu nhanh
```bash
# Kết nối SSH
./cavat_remote_quickstart.sh connect

# Kiểm tra trạng thái
./cavat_remote_quickstart.sh status

# Xem GPU
./cavat_remote_quickstart.sh gpu

# Lưu code
./cavat_remote_quickstart.sh save
```

## 📂 Cấu trúc Project

```
MathAI-support-Project/
├── README.md                        # File này
├── Ý tưởng.pdf                     # Bản ý tưởng chi tiết dự án
├── kaggle_remote_dev_setup.ipynb    # Notebook setup môi trường Kaggle
├── vscode_ssh_config_guide.md       # Hướng dẫn kết nối VS Code
├── cavat_remote_quickstart.sh       # Script tham chiếu nhanh
├── .gitignore                       # Git ignore rules
└── (sẽ bổ sung thêm khi phát triển)
    ├── frontend/                    # ReactJS + Vite
    ├── backend/                     # FastAPI + AI models
    ├── data/                        # Training data (JSONL)
    └── models/                      # Fine-tuned model weights
```

## 🔧 Tech Stack

| Component | Technology |
|-----------|------------|
| LLM | Qwen 2.5 - 1.5B |
| Fine-tuning | QLoRA (4-bit quantization) |
| RAG | Custom Python + FAISS |
| Frontend | ReactJS + Vite + Yarn |
| Backend | FastAPI |
| Deployment | Docker |
| GPU | Kaggle T4 (dev) / On-premise (prod) |
| Vision | Qwen2-VL / OCR API |
| Math Engine | SymPy (Code Interpreter) |

## 📝 License

Dự án đồ án tốt nghiệp - Kỹ thuật Máy tính.

---

*Built with ❤️ by CAVAT Team*

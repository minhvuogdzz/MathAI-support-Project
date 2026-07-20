from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="CAVAT AI Tutor API",
    description="Backend API cho hệ thống trợ giảng Toán học CAVAT",
    version="1.0.0"
)

# Cấu hình CORS để cho phép Frontend gọi API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Trong thực tế nên giới hạn domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": "Welcome to CAVAT AI Tutor API"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

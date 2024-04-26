# main.py
from fastapi import FastAPI, WebSocket
from typing import List

app = FastAPI()

"""
Este exemplo básico demonstra a comunicação via WebSocket entre um frontend Flutter e um backend Python. Para um app de flexões, você adaptaria o backend para processar imagens recebidas e implementaria lógica para detectar flexões, enquanto no frontend, ajustaria para capturar e enviar frames da câmera, além de apresentar os resultados.

"""


class ConnectionManager:
    def __init__(self):
        self.active_connections: List[WebSocket] = []

    async def connect(self, websocket: WebSocket):
        await websocket.accept()
        self.active_connections.append(websocket)

    async def disconnect(self, websocket: WebSocket):
        self.active_connections.remove(websocket)

    async def send_personal_message(self, message: str, websocket: WebSocket):
        await websocket.send_text(message)


manager = ConnectionManager()


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await manager.connect(websocket)
    try:
        while True:
            data = await websocket.receive_text()
            # Aqui você pode adicionar o processamento da mensagem
            await manager.send_personal_message(f"Echo: {data}", websocket)
    except Exception as e:
        await manager.disconnect(websocket)

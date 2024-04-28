from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Comando(BaseModel):
    acao: str


@app.post("/comando")
async def enviar_comando(comando: Comando):
    if comando.acao.upper() == "LIGAR":
        # Código para enviar comando de ligar para o Arduino
        return {"message": "Comando de ligar enviado para o Arduino"}
    elif comando.acao.upper() == "DESLIGAR":
        # Código para enviar comando de desligar para o Arduino
        return {"message": "Comando de desligar enviado para o Arduino"}
    else:
        return {"error": "Ação inválida. Use 'ligar' ou 'desligar'"}

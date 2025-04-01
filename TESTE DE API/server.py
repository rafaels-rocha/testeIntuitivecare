from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd
from typing import List
import re

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


try:
    df = pd.read_csv('../TESTE DE BANCO DE DADOS/relatorios/Relatorio_cadop.csv', delimiter=';')

except FileNotFoundError:
    print("CSV file not found. Please ensure the file path is correct.")
    df = pd.DataFrame()
    
@app.get("/")
async def root():
    return {"message": "Welcome to the API!"}


@app.get("/search")
async def search_operators(q: str = Query(..., min_length=1)):
    if df.empty:
        return {"error": "Database not loaded", "results": []}
    

    q = q.lower()
 
    mask = df.apply(lambda x: x.astype(str).str.lower().str.contains(q, regex=False)).any(axis=1)
    results = df[mask].to_dict('records')
    
    return {"results": results[:10]}  

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
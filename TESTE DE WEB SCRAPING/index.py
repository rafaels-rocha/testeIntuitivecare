import os
import requests

# URLs dos arquivos PDF
pdf_urls = [
    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_II_DUT_2021_RN_465.2021_RN628.2025_RN629.2025.pdf",
    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
]

output_folder = "downloads"
os.makedirs(output_folder, exist_ok=True)

def download_file(url, folder):
    filename = os.path.join(folder, url.split("/")[-1])
    response = requests.get(url, stream=True)
    
    if response.status_code == 200:
        with open(filename, "wb") as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"Download concluído: {filename}")
    else:
        print(f"Erro ao baixar {url}: Código {response.status_code}")


for pdf_url in pdf_urls:
    download_file(pdf_url, output_folder)
